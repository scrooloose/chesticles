require File.dirname(__FILE__) + '/spec_helper.rb'

describe Knight do
  include BoardHelpers

  it "should implement the legal_move?(move) slot" do
    k = Knight.new(Square.new(1,1), Player.white, boards(:start))
    k.send(:legal_move?, k.move_for(Square.new(1,0)))
  end
end
