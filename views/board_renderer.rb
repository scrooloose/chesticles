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

      case key
      when 56
        @current_square = Square.new(@current_square.x, @current_square.y - 1)
      when 50
        @current_square = Square.new(@current_square.x, @current_square.y + 1)
      when 52
        @current_square = Square.new(@current_square.x - 1, @current_square.y)
      when 54
        @current_square = Square.new(@current_square.x + 1, @current_square.y)

      when 55
        @current_square = Square.new(@current_square.x - 1, @current_square.y - 1)
      when 57
        @current_square = Square.new(@current_square.x + 1, @current_square.y - 1)
      when 49
        @current_square = Square.new(@current_square.x - 1, @current_square.y + 1)
      when 51
        @current_square = Square.new(@current_square.x + 1, @current_square.y + 1)

      when 53
        square_selected
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
