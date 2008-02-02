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



  def move_to(square)
    raise(NotImplementedError, "move_to not implemented for #{self.class.name}")
  end

  def legal?(move)
    raise(NotImplementedError, "legal_move? not implemented for #{self.class.name}")
  end

end
