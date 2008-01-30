class Move
  class InvalidDestinationSquareError < StandardError; end
  class InvalidOperationError < StandardError; end

  attr_reader :piece, :square

  def initialize(piece, square)
    @piece = piece
    @square = square

    raise(InvalidDestinationSquareError, "Cant move to same square") if square == piece.square
  end

  def to_occupied_square?
    !to_empty_square?
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

  def direction?(heading, dist = nil)

    dx = dx_for_player
    dy = dy_for_player

    case heading
    when :left
      return false unless(dx < 0 && horizontal?)
    when :right
      return false unless(dx > 0 && horizontal?)
    when :forward
      return false unless(dy > 0 && vertical?)
    when :back
      return false unless(dx < 0 && vertical?)
    when :back_left
      return false unless(dx < 0 && dy < 0 && diagonal?)
    when :back_right
      return false unless(dx < 0 && dy < 0 && diagonal?)
    when :forward_left
      return false unless(dx < 0 && dy > 0 && diagonal?)
    when :forward_right
      puts dx, dy, diagonal?
      return false unless(dx > 0 && dy > 0 && diagonal?)
    end

    return false if !dist.nil? && distance != dist
    true
  end



  def dy_for_player
    @ydelta ||= begin
      ydelta = start_square.y_delta_to(square)
      ydelta = -ydelta if player.white?
      ydelta
    end
  end

  def dx_for_player
    @xdelta ||= begin
      xdelta = start_square.x_delta_to(square)
      xdelta = -xdelta if player.black?
      xdelta
    end
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
    unless horizontal? || vertical? || diagonal?
      raise(InvalidOperationError, "can only find squares between for straight moves")
    end

    if horizontal?
      return (min_x..max_x).map {|x| Square.new(x, square.y)}
    elsif vertical?
      return (min_y..max_y).map {|y| Square.new(square.x, y)}
    elsif diagonal?
      xdiff = square.x - start_square.x 

      #there are no between squares 
      return [] if xdiff == 1

      xstep = xdiff / xdiff.abs
      startx = start_square.x + xstep
      endx = square.x - xstep

      return (startx..endx).map do |x| 
        y = start_square.y + x - start_square.x
        Square.new(x,y)
      end
       
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



  private
    def player
      piece.player
    end

    def board
      piece.board
    end
end
