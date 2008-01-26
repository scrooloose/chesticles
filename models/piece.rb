class Piece
  class NotImplementedError < StandardError; end


  attr_reader :square

  def initialize(square)
    @square = square
  end

  def self.new_by_coordinates(x,y)
    new(Square.new(x,y))
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
