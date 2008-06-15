#!/usr/bin/env ruby

require 'requires'

game = Game.new
if ARGV.include? "--use-gtk"
  require 'views/gtk_board_renderer'
  br = GtkBoardRenderer.new(game.board)
elsif ARGV.include? "--use-ncurses"
  require 'views/ncurses_board_renderer'
  br = NcursesBoardRenderer.new(game.board)
  br.main_loop
else
  require 'views/board_renderer'
  br = BoardRenderer.new(game.board)
  br.main_loop
end


