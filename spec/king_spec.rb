require File.dirname(__FILE__) + '/spec_helper.rb'

describe King do
  it "should implement the legal_move?(move) slot" do
    k = King.new(Square.new(1,1), Player.white, Board.new)
    k.send(:legal_move?, k.move_for(Square.new(2,2)))
  end
end
