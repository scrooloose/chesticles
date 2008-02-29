#!/usr/bin/env ruby

require 'requires'

board = Board.new
br = BoardRenderer.new(board)
br.main_loop
