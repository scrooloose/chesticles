require File.dirname(__FILE__) + '/spec_helper.rb'

describe Queen do
  include BoardHelpers

  it "should implement the legal_move?(move) slot" do
    q = Queen.new(Square.new(1,1), Player.white, boards(:start))
    q.send(:legal_move?, q.move_for(Square.new(1,0)))
  end
end
