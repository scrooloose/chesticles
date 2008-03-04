require File.dirname(__FILE__) + '/spec_helper.rb'

describe King do
  include BoardHelpers

  it "should implement the legal_move?(move) slot" do
    k = King.new(Square.new(1,1), Player.white, boards(:start))
    k.send(:legal_move?, k.move_for(Square.new(2,2)))
  end

  it "should castle white left" do
    b = boards(:kings_and_rooks_only)
    b.king_for(Player.white).move_to(Square.new(2,7))
    b.piece_for(Square.new(3,7)).should be_an_instance_of(Rook)

  end

  it "should castle white right" do
    b = boards(:kings_and_rooks_only)
    b.king_for(Player.white).move_to(Square.new(6,7))
    b.piece_for(Square.new(5,7)).should be_an_instance_of(Rook)
  end

  it "should castle black right" do
    b = boards(:kings_and_rooks_only)
    b.game.toggle_turn
    b.king_for(Player.black).move_to(Square.new(2,0))
    b.piece_for(Square.new(3,0)).should be_an_instance_of(Rook)
  end

  it "should castle black left" do
    b = boards(:kings_and_rooks_only)
    b.game.toggle_turn
    b.king_for(Player.black).move_to(Square.new(6,0))
    b.piece_for(Square.new(5,0)).should be_an_instance_of(Rook)
  end
end
