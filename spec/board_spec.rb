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
