require File.dirname(__FILE__) + '/spec_helper.rb'

describe Pawn do
  include BoardHelpers
  include MoveHelpers

  it "should implement the legal_move?(move) slot" do
    p = Pawn.new(Square.new(1,1), Player.white, boards(:start))
    p.send(:legal_move?, p.move_for(Square.new(1,0)))
  end

  it "should be replaced with a queen when it reached the end of the board" do
    m = moves(:white_gets_new_queen)
    m.execute
    m.board.piece_for(m.square).should be_an_instance_of(Queen)
  end
end
