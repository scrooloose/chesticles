require File.dirname(__FILE__) + '/spec_helper.rb'

describe Square do
  it "should return #squares_between when self and the target square form a horizontal, diagonal or vertical line" do
    squares = Square.new(1,1).squares_between(Square.new(4,1))
    squares.size.should equal(2)
    squares.include?(Square.new(2,1)).should be
    squares.include?(Square.new(3,1)).should be

    squares = Square.new(1,1).squares_between(Square.new(1,4))
    squares.size.should equal(2)
    squares.include?(Square.new(1,2)).should be
    squares.include?(Square.new(1,3)).should be

    squares = Square.new(1,1).squares_between(Square.new(4,4))
    squares.size.should equal(2)
    squares.include?(Square.new(2,2)).should be
    squares.include?(Square.new(3,3)).should be
  end

  it "should fail on #squares_between when self and the target arent in line vertically, horizontally or diagonally" do
    lambda {Square.new(1,1).squares_between(Square.new(3,2))}.should raise_error(Square::InvalidOperationError)
  end
end
