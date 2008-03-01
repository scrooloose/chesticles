require File.dirname(__FILE__) + '/spec_helper.rb'

describe Pawn do
  it "should respond define the protected legal_move?(move)" do
    p = Pawn.new(Square.new(1,1), Player.white, Board.new)
    p.send(:legal_move?, p.move_for(Square.new(1,0)))
  end
end
