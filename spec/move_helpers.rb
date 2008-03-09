module MoveHelpers
  def moves(sym)
    case sym
    when :white_kings_pawn_forward
      b = Game.new.board
      Move.new(b.piece_for(Square.new(4,6)), Square.new(4,5))
    when :white_checks_black
      b = Game.new.board
      b.pieces.clear
      b.pieces << King.new(Square.new(4,4), Player.black, b)
      white_rook = Rook.new(Square.new(5,5), Player.white, b)
      b.pieces << white_rook
      white_rook.move_for(Square.new(5,4))
    when :white_move_that_checks_self
      b = Game.new.board
      b.pieces.clear
      b.pieces << King.new(Square.new(4,7), Player.white, b)
      white_rook = Rook.new(Square.new(4,6), Player.white, b)
      black_rook = Rook.new(Square.new(4,0), Player.black, b)
      b.pieces << white_rook
      b.pieces << black_rook

      white_rook.move_for(Square.new(5,6))
    when :white_gets_new_queen
      b = Game.new.board
      b.pieces.clear
      b.pieces << King.new(Square.new(4,7), Player.white, b)
      b.pieces << King.new(Square.new(0,7), Player.black, b)
      b.pieces << pawn = Pawn.new(Square.new(0,1), Player.white, b)
      pawn.move_for(Square.new(0,0))
    when :black_gets_new_queen
      b = Game.new.board
      b.pieces.clear
      b.pieces << King.new(Square.new(4,7), Player.white, b)
      b.pieces << King.new(Square.new(0,7), Player.black, b)
      b.pieces << pawn = Pawn.new(Square.new(0,6), Player.black, b)
      pawn.move_for(Square.new(0,7))
    end

  end
end
