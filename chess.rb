#!/usr/bin/env ruby

require 'requires'

game = Game.new
br = BoardRenderer.new(game.board)
br.main_loop
