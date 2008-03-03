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
    end
  end
end
