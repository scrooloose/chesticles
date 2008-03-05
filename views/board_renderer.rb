class BoardRenderer
  include HighLine::SystemExtensions
  class InvalidPieceError < StandardError; end

  attr_reader :board

  def initialize(board)
    @board = board
    @current_square = Square.new(4, 6)
  end

  def render
    output = ""

    0.upto(7) do |y|
      0.upto(7) do |x|
        s = Square.new(x,y)
        p = @board.piece_for(s)

        bg_col = if s == @current_square
          :cyan
        elsif @selected_square && s == @selected_square
          :yellow
        elsif s.white? 
          :white
        else
          :red 
        end

        piece_char = if p
          char_for(p)
        else
          " "
        end

        output << " #{piece_char} ".color(:bg => bg_col)
      end

      output << "\n"
    end

    system("clear")
    puts output
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
    while !@done
      render
      key = get_character

      if key == 53
        square_selected
      else
        xdiff, ydiff = 0,0
        case key
        when 56: ydiff = -1
        when 50: ydiff = 1
        when 52: xdif = -1
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
  end

  def kill_main_loop
    @done = true
  end

  def square_selected
    if @selected_square.nil?
      @selected_square = @current_square
    else
      p = @board.piece_for(@selected_square)
      m = Move.new(p, @current_square)
      m.execute
      @selected_square = nil
    end
  end
end
