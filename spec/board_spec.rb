require File.dirname(__FILE__) + '/spec_helper.rb'

describe Board, "that has just been reset" do
  include BoardHelpers

  it "should have 32 pieces" do
    b = boards(:start)
    b.pieces.size.should equal(32)
  end
end

describe Board do
  include BoardHelpers

  it "should have a Game" do
    boards(:start).should respond_to(:game)
  end

  it "should return the black king for #king_for(Player.black)" do
    k = boards(:start).king_for(Player.black)
    k.player.should equal(Player.black)
    k.class.should equal(King)
  end

  it "should return the white king for #king_for(Player.white)" do
    k = boards(:start).king_for(Player.white)
    k.player.should equal(Player.white)
    k.class.should equal(King)
  end

  it "should return a Piece for #piece_for_xy iff there is a Piece at the given coordinates" do
    boards(:start).piece_for_xy(4,6).should be_a_kind_of(Piece)
    boards(:start).piece_for_xy(4,5).should_not be
  end
end

describe Board, "when a player is in checkmate" do
  include BoardHelpers
  it "should return true for #checkmate_for?(Player.black) if black is mated" do
    boards(:black_checkmated).checkmate_for?(Player.black).should be
  end

  it "should return true for #checkmate_for?(Player.white) if white is mated" do
    boards(:white_checkmated).checkmate_for?(Player.white).should be
  end
end

describe Board, "when a player isnt in checkmate" do
  include BoardHelpers
  it "shouldnt think any player is in checkmate if their king isnt threatened" do
    boards(:start).checkmate_for?(Player.black).should_not be
    boards(:start).checkmate_for?(Player.white).should_not be
  end

  it "shouldnt think a player is checkmated if they are in check but can move their king" do
    b = boards(:kings_only)
    b.game.toggle_turn
    b.pieces << Queen.new(Square.new(4, 6), Player.white, b)
    b.checkmate_for?(Player.black).should_not be
  end

  it "shouldnt think a player is checkmated if they are in check but can take the threatening piece" do
    b = boards(:kings_only)
    b.game.toggle_turn

    #put the white queen right in front of the black king
    b.pieces << Queen.new(Square.new(4, 1), Player.white, b)

    #surround the black king with his own pawns
    b.pieces << Pawn.new(Square.new(3, 0), Player.black, b)
    b.pieces << Pawn.new(Square.new(5, 0), Player.black, b)
    b.pieces << Pawn.new(Square.new(3, 1), Player.black, b)
    b.pieces << Pawn.new(Square.new(5, 1), Player.black, b)

    b.checkmate_for?(Player.black).should_not be
  end
end
