require File.dirname(__FILE__) + '/spec_helper.rb'

describe Piece do
  include TestBoards
  include MoveHelpers

  
  it "should delegate #black? and #white? to player" do
    p = boards(:start).pieces.first

    p.player.should_receive :black? 
    p.black?

    p.player.should_receive :white? 
    p.white?
  end

  it "should delegate #x and #y to #square" do
    p = boards(:start).pieces.first

    p.square.should_receive :x 
    p.x

    p.square.should_receive :y 
    p.y
  end

  it "should respond to #legal?(move)" do
    m = test_move
    m.piece.should respond_to(:legal?)
    test_move
  end

  it "should raise an exception in response to #legal_move?(move)" do
    p = Piece.new(Square.new(0,0), Player.white, Board.new)
    lambda {p.send(:legal_move?, test_move)}.should raise_error(Piece::NotImplementedError)
  end
end
