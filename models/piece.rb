class Piece
  class NotImplementedError < StandardError; end
  class IllegalMoveError < StandardError; end


  attr_reader :square, :player

  def initialize(square, player)
    @square = square
    @player = player
  end

  def self.new_by_xy(x, y, player)
    new(Square.new(x,y), player)
  end

  def x
    @square.x
  end

  def y
    @square.y
  end

  def move_to(square)
    raise(NotImplementedError, "move_to not implemented for #{self.class.name}")
  end

  def legal_move?(square)
    raise(NotImplementedError, "legal_move? not implemented for #{self.class.name}")
  end

end
