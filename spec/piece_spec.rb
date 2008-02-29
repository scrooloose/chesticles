require File.dirname(__FILE__) + '/spec_helper.rb'

describe Piece do
  include TestBoards
  
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
end
