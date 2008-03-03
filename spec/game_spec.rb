require File.dirname(__FILE__) + "/spec_helper.rb"

describe Game do
  it "should have a board" do
    Game.new.should respond_to(:board)
    Game.new.board.should be_an_instance_of(Board)
  end

  it "should respond to #blacks_turn? and #whites_turn?" do
    Game.new.should respond_to(:whites_turn?, :blacks_turn?)
  end

  it "should return the other player for #current_player after #toggle_turn is called" do
    g = Game.new
    p = g.current_player
    g.toggle_turn
    g.current_player.should_not equal(p)
  end
end

describe Game, "that has just been created" do
  it "should start with white as the first player to move" do
    Game.new.current_player.should equal(Player.white)
  end
end

