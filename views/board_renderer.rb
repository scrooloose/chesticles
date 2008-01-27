class BoardRenderer
  class InvalidPieceError < StandardError; end

  attr_reader :board

  def initialize(board)
    @board = board
  end

  def render
    output = ""

    0.upto(7) do |y|
      0.upto(7) do |x|
        s = Square.new(x,y)
        p = @board.piece_for(s)

        bg_col = if s.white? 
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


end
