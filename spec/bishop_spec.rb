require File.dirname(__FILE__) + '/spec_helper.rb'

describe Bishop do
  include BoardHelpers

  it "should implement the legal_move?(move) slot" do
    b = Bishop.new(Square.new(1,1), Player.white, boards(:start))
    b.send(:legal_move?, b.move_for(Square.new(2,2)))
  end
end
