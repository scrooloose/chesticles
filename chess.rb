#!/usr/bin/env ruby

require 'requires'

game = Game.new
if ARGV.include? "--use-gtk"
  br = GtkBoardRenderer.new(game.board)
else
  br = BoardRenderer.new(game.board)
  br.main_loop
end


