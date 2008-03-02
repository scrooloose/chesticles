require File.dirname(__FILE__) + "/spec_helper.rb"

describe Move do
  include BoardHelpers
  include MoveHelpers

  it "should delegate #board and #player to #piece" do

    #the white kings pawn 
    p = boards(:start).piece_for(Square.new(4, 6))
    m = p.move_for(Square.new(4,5))

    m.piece.should_receive(:board)
    m.board

    m.piece.should_receive(:player)
    m.player
    
  end

  it "should return true for #checks_enemy? if the piece threatens the enemy king after the move" do
    m = moves(:white_checks_black)
    m.checks_enemy?.should be
    m.execute
    black_king = m.board.king_for(Player.black)
    m.piece.threatening?(black_king.square).should be
  end
end
