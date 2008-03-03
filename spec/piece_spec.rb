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
    m = moves(:white_kings_pawn_forward)
    m.piece.should respond_to(:legal?)
  end

  it "should raise an exception in response to #legal_move?(move)" do
    p = Piece.new(Square.new(0,0), Player.white, boards(:start))
    m = moves(:white_kings_pawn_forward)
    lambda {p.send(:legal_move?, m)}.should raise_error(Piece::NotImplementedError)
  end

  it "should report a move as illegal if it is not the piece's player's turn" do
    #grab the black kings pawn 
    p = boards(:start).piece_for(Square.new(4,1))

    #moving it should be illegal cos its whites turn 
    m = p.move_for(Square.new(4,2))
    p.legal?(m).should_not be
  end

  it "should become the other players turn after #move is called" do
    #grab the white kings pawn 
    p = boards(:start).piece_for(Square.new(4,6))
    p.move(p.move_for(Square.new(4,5)))

    p.board.game.current_player.should equal(Player.black)
  end

  it "should return true for #moved? only after #move has successfully executed" do
    m = moves(:white_kings_pawn_forward)
    m.piece.moved?.should_not be
    m.execute
    m.piece.moved?.should be

    b = boards(:start)
    k = b.king_for(Player.white)
    illegal_move = k.move_for(Square.new(0,0))
    begin
      illegal_move.execute
    rescue Piece::IllegalMoveError
    end
    k.moved?.should_not be
  end
end
