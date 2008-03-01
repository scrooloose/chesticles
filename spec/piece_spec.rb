require File.dirname(__FILE__) + '/spec_helper.rb'

describe Piece do
  include BoardHelpers
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
    p = Piece.new(Square.new(0,0), Player.white, boards(:start))
    lambda {p.send(:legal_move?, test_move)}.should raise_error(Piece::NotImplementedError)
  end

  it "should report a move as illegal if it is not the piece's player's turn" do
    #grab the black kings pawn 
    p = boards(:start).piece_for(Square.new(4,1))

    #moving it should be illegal cos its whites turn 
    m = p.move_for(Square.new(4,2))
    p.legal?(m).should_not be
  end
end
