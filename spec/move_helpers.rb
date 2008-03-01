module MoveHelpers
  def test_move
    b = Board.new(Game.new)
    Move.new(b.piece_for(Square.new(4,6)), Square.new(4,5))
  end
end
