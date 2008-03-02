module MoveHelpers
  def moves(sym)
    case sym
    when :white_kings_pawn_forward
      b = Board.new(Game.new)
      Move.new(b.piece_for(Square.new(4,6)), Square.new(4,5))
    when :white_checks_black
      b = Board.new(Game.new)
      b.king_for(Player.black).square = Square.new(4,4)
      white_rook = b.piece_for(Square.new(5,5))
      white_rook.move_for(Square.new(5,4))
    end
  end
end
