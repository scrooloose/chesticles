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
end
