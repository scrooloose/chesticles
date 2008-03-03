class Move
  class Error < StandardError; end
  class InvalidDestinationSquareError < Error; end
  class InvalidOperationError < Error; end

  attr_reader :piece, :square

  delegate :board, :player, :to => :piece

  def initialize(piece, square)
    @piece = piece
    @square = square
  end

  def checks_enemy?
    enemy_king = board.pieces.find {|p| p.is_a?(King) && p.player != player}
    piece.temporarily_move_to(square) do |p|
      board.threatened?(enemy_king.square, player) 
    end
  end

  def checks_self?
    our_king = board.pieces.find {|p| p.is_a?(King) && p.player == player}
    piece.temporarily_move_to(square) do |p|
      board.threatened?(our_king.square, player.enemy) 
    end
  end

  def to_occupied_square?
    !to_empty_square?
  end

  def to_enemy_occupied_square?
    p = board.piece_for(square)
    p && p.player != player
  end

  def to_empty_square?
    board.piece_for(square).nil?
  end

  def horizontal?
    dy_for_player == 0 && dx_for_player != 0
  end

  def vertical?
    dy_for_player != 0 && dx_for_player == 0
  end

  def diagonal?
    dy_for_player.abs == dx_for_player.abs
  end

  def straight?
    horizontal? || vertical? || diagonal?
  end


  def direction?(heading, dist = nil)
    return false if direction != heading
    return false if dist && distance != dist
    true
  end

  def direction
    dx = dx_for_player
    dy = dy_for_player

    return :left if(dx < 0 && horizontal?)
    return :right if(dx > 0 && horizontal?)
    return :forward if(dy > 0 && vertical?)
    return :back if(dx < 0 && vertical?)
    return :back_left if(dx < 0 && dy < 0 && diagonal?)
    return :back_right if(dx < 0 && dy < 0 && diagonal?)
    return :forward_left if(dx < 0 && dy > 0 && diagonal?)
    return :forward_right if(dx > 0 && dy > 0 && diagonal?)
  end



  def dy_for_player
    @dy_for_player ||= begin
      ydelta = start_square.y_delta_to(square)
      ydelta = -ydelta if player.white?
      ydelta
    end
  end

  def dx_for_player
    @dx_for_player ||= begin
      xdelta = start_square.x_delta_to(square)
      xdelta = -xdelta if player.black?
      xdelta
    end
  end

  def dx
    @dx ||= start_square.x_delta_to(square)
  end

  def dy
    @dy ||= start_square.y_delta_to(square)
  end


  def distance
    @distance ||= if vertical?
      dy_for_player.abs
    elsif horizontal?
      dx_for_player.abs
    elsif diagonal?
      dx_for_player.abs
    else
      raise(InvalidOperationError, "Cannot compute distance for a non-straight move")
    end
  end

  def start_square
    piece.square
  end

  def squares_between
    square.squares_between piece.square
  end

  def clear_path?
    raise(InvalidOperationError, "move must be straight") unless straight?
    squares_between.all? do |s| 
      board.piece_for(s).nil?
    end
  end

  def min_x
    square.x < start_square.x ? square.x : start_square.x
  end

  def max_x
    square.x > start_square.x ? square.x : start_square.x
  end

  def min_y
    square.y < start_square.y ? square.y : start_square.y
  end

  def max_y
    square.y > start_square.y ? square.y : start_square.y
  end

  def execute
    piece.move(self)
  end

  def trying_to_capture_own_piece?
    p = board.piece_for(square)
    p && p.player == player
  end

  def moving_to_same_square?
    square == @piece.square 
  end

  def castle?
    return false unless piece.is_a?(King) && !piece.moved? && dx.abs == 2 && horizontal?
    
    rook_square = if direction?(:left)
      player.white? ? Square.new(0,7) : Square.new(7,0)
    elsif direction?(:right)
      player.white? ? Square.new(7,7) : Square.new(0,0)
    end

    rook = board.piece_for(rook_square)
    rook.is_a?(Rook) && !rook.moved?
  end

end
