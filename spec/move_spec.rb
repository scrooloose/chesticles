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

  it "should return false for #castle? if #piece isnt a king" do
    moves(:white_kings_pawn_forward).castle?.should_not be
  end

  it "should return false for #castle? if the king has moved" do
    b = boards(:kings_only)
    b.pieces << Rook.new(Square.new(0,7), Player.white, b)

    #move the white king left then back then see if we can castle 
    b.king_for(Player.white).move_for(Square.new(3,7)).execute
    b.game.toggle_turn
    b.king_for(Player.white).move_for(Square.new(4,7)).execute
    b.game.toggle_turn
    b.king_for(Player.white).move_for(Square.new(2,7)).castle?.should_not be
  end

  it "should return false for #castle? if the king is not moving 2 squares left or right" do
    b = boards(:kings_and_white_rooks_only)
    b.king_for(Player.white).move_for(Square.new(1,7)).castle?.should_not be

    b = boards(:kings_and_white_rooks_only)
    b.king_for(Player.white).move_for(Square.new(5,7)).castle?.should_not be
  end

  it "should return false for #castle? if the rook has moved" do
    b = boards(:kings_and_white_rooks_only)
    b.piece_for(Square.new(0,7)).move_to(Square.new(1,7))
    b.game.toggle_turn
    b.piece_for(Square.new(1,7)).move_to(Square.new(0,7))
    b.game.toggle_turn
    b.king_for(Player.white).move_for(Square.new(2,7)).castle?.should_not be
  end

  it "should return true for #castle? if the move is a legal castle" do
    b = boards(:kings_and_white_rooks_only)
    b.king_for(Player.white).move_for(Square.new(2,7)).castle?.should be
    b.king_for(Player.white).move_for(Square.new(6,7)).castle?.should be
  end

end
