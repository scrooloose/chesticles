require File.dirname(__FILE__) + '/spec_helper.rb'

describe Queen do
  it "should respond define the protected legal_move?(move)" do
    q = Queen.new(Square.new(1,1), Player.white, Board.new)
    q.send(:legal_move?, q.move_for(Square.new(1,0)))
  end
end
