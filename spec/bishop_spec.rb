require File.dirname(__FILE__) + '/spec_helper.rb'

describe Bishop do
  it "should respond define the protected legal_move?(move)" do
    b = Bishop.new(Square.new(1,1), Player.white, Board.new)
    b.send(:legal_move?, b.move_for(Square.new(2,2)))
  end
end
