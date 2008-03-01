require File.dirname(__FILE__) + '/spec_helper.rb'

describe Rook do
  it "should implement the legal_move?(move) slot" do
    r = Rook.new(Square.new(1,1), Player.white, Board.new)
    r.send(:legal_move?, r.move_for(Square.new(1,0)))
  end
end
