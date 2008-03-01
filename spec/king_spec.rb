require File.dirname(__FILE__) + '/spec_helper.rb'

describe King do
  it "should respond define the protected legal_move?(move)" do
    k = King.new(Square.new(1,1), Player.white, Board.new)
    k.send(:legal_move?, k.move_for(Square.new(2,2)))
  end
end
