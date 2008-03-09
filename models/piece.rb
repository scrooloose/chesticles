class Piece
  class NotImplementedError < StandardError; end
  class IllegalMoveError < StandardError; end


  attr_reader :player, :board
  attr_accessor :square

  delegate :black?, :white?, :to => :player
  delegate :x, :y, :to => :square

  def initialize(square, player, board)
    @square = square
    @player = player
    @board = board
  end

  def self.new_by_xy(x, y, player, board)
    new(Square.new(x,y), player, board)
  end

  def move_for(square)
    Move.new(self, square)
  end

  def move_to(square)
    move_for(square).execute
  end

  def move(move)
    raise(IllegalMoveError, "illegal move from #{square} -> #{move.square}") unless legal?(move)
    board.piece_captured(board.piece_for(move.square))
    @square = move.square
    @moved = true
    board.game.toggle_turn
  end

  def moved?
    @moved 
  end

  def legal?(move)
    passes_basic_checks?(move) && legal_move?(move) 
  end

  def threatening?(square)
    legal_move?(move_for(square))
  rescue Move::InvalidDestinationSquareError
    false
  end

  def temporarily_move_to(square, &block)
    old_square = @square 
    old_piece = board.pieces.delete(board.piece_for(square))
    @square = square
    to_return = block.call(self)
    @square = old_square
    board.pieces << old_piece if old_piece
    to_return
  end

  def this_players_turn?
    board.game.current_player == player
  end


  def to_s
    "#{self.class.name}: #{player.color}, #{square}"
  end

  protected
  def legal_move?(move)
    raise(NotImplementedError, "legal_move? not implemented for #{self.class.name}")
  end

  def passes_basic_checks?(move)
    return false unless this_players_turn?
    return false if move.checks_self?
    return false if move.moving_to_same_square?
    return false if move.trying_to_capture_own_piece?
    true
  end

end
