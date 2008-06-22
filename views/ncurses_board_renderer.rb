require 'ncurses'

class NcursesBoardRenderer
  class InvalidPieceError < StandardError; end

  attr_reader :board

  @@colors = {
    :black_square => 1,
    :white_square => 2,
    :selected_square => 3,
    :messages => 4
  }
  def color_pair_for(color_name)
    Ncurses.COLOR_PAIR(@@colors[color_name.to_sym])
  end



  def initialize(board)
    @board = board
    @current_square = Square.new(4, 6)
    @messages = []
  end

  def render
    Ncurses.clear
    0.upto(7) do |x|
      0.upto(7) do |y|
        square = Square.new(x,y)
        piece = piece = @board.piece_for(square)

        color = if @current_square == square || (@selected_square && @selected_square == square)
          color_pair_for(:selected_square)
        else
          square.black? ? color_pair_for(:black_square) : color_pair_for(:white_square)
        end

        str_to_render = piece ?  " #{char_for(piece)} " : "   "

        @win.attron(color)
        Ncurses.mvaddstr(y, x*3, str_to_render)
        @win.attroff(color)
      end
    end

    @win.attron(color_pair_for(:messages))
    @messages.each_with_index do |message,i|
        Ncurses.mvaddstr(9+i, 0, message)
    end
    @win.attroff(color_pair_for(:messages))
    @messages.clear

    Ncurses.refresh
  end

  def char_for(piece)
    char = case piece
      when Pawn: "p"
      when King: "k"
      when Queen: "q"
      when Rook: "r"
      when Bishop: "b"
      when Knight: "h"
      else
        raise(InvalidPieceError, "Unknown piece of class:#{piece.class}")
    end

    if piece.player.black?
      char = char.upcase
    end

    char
  end

  def main_loop
    @done = false
    @win = Ncurses.initscr
    Ncurses.noecho
    Ncurses.nl
    Ncurses.curs_set(0)
    Ncurses.start_color
    Ncurses.init_pair(@@colors[:white_square],    Ncurses::COLOR_WHITE, Ncurses::COLOR_RED);
    Ncurses.init_pair(@@colors[:black_square],    Ncurses::COLOR_WHITE, Ncurses::COLOR_YELLOW);
    Ncurses.init_pair(@@colors[:selected_square], Ncurses::COLOR_WHITE, Ncurses::COLOR_BLUE);
    Ncurses.init_pair(@@colors[:messages],        Ncurses::COLOR_WHITE, Ncurses::COLOR_BLACK);

    while !@done
      render
      key = Ncurses.getch

      if key == 53
        square_selected
      else
        xdiff, ydiff = 0,0
        case key
        when 56: ydiff = -1
        when 50: ydiff = 1
        when 52: xdiff = -1
        when 54: xdiff = 1
        when 55: xdiff, ydiff = -1, -1
        when 57: xdiff, ydiff = 1, -1
        when 49: xdiff, ydiff = -1, 1
        when 51: xdiff, ydiff = 1, 1
        end

        begin
          @current_square = Square.new(@current_square.x + xdiff, @current_square.y + ydiff)
        rescue Square::InvalidCoordinateError
          #trying to move the cursor off the board, do nothing
        end
      end
    end
  ensure
    Ncurses.curs_set(1)
    Ncurses.endwin
  end

  def kill_main_loop
    @done = true
  end

  def square_selected
    if @selected_square.nil?
      @selected_square = @current_square if @board.piece_for(@current_square)
    else
      begin
        @board.piece_for(@selected_square).move_to(@current_square)
      rescue Piece::IllegalMoveError
        message_for_user "Illegal move sunshine"
      end
      @selected_square = nil
    end
  end

  def message_for_user(msg)
    @messages << msg
  end

end
