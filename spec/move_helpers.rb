module MoveHelpers
  def moves(sym)
    case sym
    when :white_kings_pawn_forward
      b = Board.new(Game.new)
      Move.new(b.piece_for(Square.new(4,6)), Square.new(4,5))
    when :white_checks_black
      b = Board.new(Game.new)
      b.pieces.clear
      b.pieces << King.new(Square.new(4,4), Player.black, b)
      white_rook = Rook.new(Square.new(5,5), Player.white, b)
      b.pieces << white_rook
      white_rook.move_for(Square.new(5,4))
    when :white_move_that_checks_self
      b = Board.new(Game.new)
      b.pieces.clear
      b.pieces << King.new(Square.new(4,7), Player.white, b)
      white_rook = Rook.new(Square.new(4,6), Player.white, b)
      black_rook = Rook.new(Square.new(4,0), Player.black, b)
      b.pieces << white_rook
      b.pieces << black_rook

      white_rook.move_for(Square.new(5,6))
    end
  end
end
