module BoardHelpers
  def boards(sym)
    case sym
    when :start: Game.new.board
    when :kings_only
      b = Game.new.board
      b.pieces.reject! {|p| !p.is_a? King}
      b
    when :kings_and_white_rooks_only
      b = Game.new.board
      b.pieces.clear
      b.pieces << Rook.new(Square.new(0,7), Player.white, b)
      b.pieces << Rook.new(Square.new(7,7), Player.white, b)
      b.pieces << king = King.new(Square.new(4,7), Player.white, b)
      b.pieces << king = King.new(Square.new(4,0), Player.black, b)
      b
    when :kings_and_rooks_only
      b = Game.new.board
      b.pieces.clear
      b.pieces << Rook.new(Square.new(0,7), Player.white, b)
      b.pieces << Rook.new(Square.new(7,7), Player.white, b)
      b.pieces << Rook.new(Square.new(0,0), Player.black, b)
      b.pieces << Rook.new(Square.new(7,0), Player.black, b)
      b.pieces << king = King.new(Square.new(4,7), Player.white, b)
      b.pieces << king = King.new(Square.new(4,0), Player.black, b)
      b
    when :black_checkmated
      b = Game.new.board
      b.pieces.clear
      b.pieces << King.new(Square.new(4,7), Player.white, b)
      b.pieces << King.new(Square.new(4,0), Player.black, b)
      b.pieces << Queen.new(Square.new(4,1), Player.white, b)
      b.pieces << Rook.new(Square.new(4,2), Player.white, b)
      b
    when :white_checkmated
      b = Game.new.board
      b.pieces.clear
      b.pieces << King.new(Square.new(4,7), Player.black, b)
      b.pieces << King.new(Square.new(4,0), Player.white, b)
      b.pieces << Queen.new(Square.new(4,1), Player.black, b)
      b.pieces << Rook.new(Square.new(4,2), Player.black, b)
      b
    end
  end
end
