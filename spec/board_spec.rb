require File.dirname(__FILE__) + '/spec_helper.rb'

describe Board, "that has just been reset" do

  it "should have 32 pieces" do
    b = Board.new
    b.pieces.size.should equal(32)
  end
end
