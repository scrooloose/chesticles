class Piece
  class NotImplementedError < StandardError; end
  class IllegalMoveError < StandardError; end


  attr_reader :square, :player, :board

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
  end

  def legal?(move)
    raise(NotImplementedError, "legal_move? not implemented for #{self.class.name}")
  end

  def threatening?(square)
    legal?(move_for(square))
  rescue Move::InvalidDestinationSquareError
    false
  end


  def to_s
    "#{self.class.name}: #{player.color}, #{square}"
  end


end
