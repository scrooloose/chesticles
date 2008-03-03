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

  it "should only return true for #checks_enemy? if the enemy king is threatened after the move" do
    m = moves(:white_checks_black)
    m.checks_enemy?.should be
    m = moves(:white_kings_pawn_forward)
    m.checks_enemy?.should_not be
  end

  it "should only return true for #checks_self? if our king is threatened after the move" do
    m = moves(:white_move_that_checks_self)
    m.checks_self?.should be

    m = moves(:white_kings_pawn_forward)
    m.checks_self?.should_not be
  end

  it "should return true for #moving_to_same_square? only if the target square is the same as the pieces current square" do
    moves(:white_kings_pawn_forward).moving_to_same_square?.should_not be
    s = Square.new(4,6)
    boards(:start).piece_for(s).move_for(s).moving_to_same_square?.should be
  end

end
