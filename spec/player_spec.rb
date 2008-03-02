require File.dirname(__FILE__) + '/spec_helper.rb'

describe Player do
  it "should define .black and .white" do
    Player.should respond_to(:black, :white)
  end

  it "should return a Player for .black and .white" do
    Player.black.should be_an_instance_of(Player)
    Player.white.should be_an_instance_of(Player)
  end

  it "should cache the Players for .black and .white" do
    p = Player.black
    p.should equal(Player.black)

    p = Player.white
    p.should equal(Player.white)
  end

  it "should return the opposing player for #enemy" do
    Player.black.enemy.should equal(Player.white)
    Player.white.enemy.should equal(Player.black)
  end
end
