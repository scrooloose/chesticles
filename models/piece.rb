class Piece
  class NotImplementedError < StandardError; end
  class IllegalMoveError < StandardError; end


  attr_reader :square, :player, :board

  def initialize(square, player, board)
    @square = square
    @player = player
    @board = board
  end

  def self.new_by_xy(x, y, player, board)
    new(Square.new(x,y), player, board)
  end

  def x
    @square.x
  end

  def y
    @square.y
  end

  def black?
    player.black?
  end

  def white?
    player.white?
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
  end

  def legal?(move)
    raise(NotImplementedError, "legal_move? not implemented for #{self.class.name}")
  end

end
