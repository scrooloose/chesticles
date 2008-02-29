require File.dirname(__FILE__) + '/spec_helper.rb'

describe Board, "that has just been reset" do

  it "should have 32 pieces" do
    #b = Board.new(Player.
    #b.pieces.size.should == 32
  end

  #it "should receive a deviceCreated response after sending a connect_message" do
    #run_in_client do |c|
      #c.connect.should =~ /^<deviceCreated /
    #end
  #end
end

#describe TeleoClient, "that has connected" do

  #it "should get a server cookie" do
    #run_in_client do |c|
      #c.server_cookie.should =~ /^0x[0-9a-f]{5,8}/i
    #end
  #end

  #it "should get a response when turning the light on" do
    #run_in_client do |c|
      #c.turn_light_on.should =~ /^<boundUpdated /
    #end
  #end

  #it "should get a response when turning the light off" do
    #run_in_client do |c|
      #c.turn_light_on.should =~ /^<boundUpdated /
    #end
  #end
#end
