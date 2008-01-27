class Board
  attr_reader :pieces

  def initialize(white, black)
    @white = white
    @black = black
    reset
  end

  def reset
    pieces.clear

    0.upto(7) do |x|
      @pieces << Pawn.new_by_xy(x, 1, @white)
      @pieces << Pawn.new_by_xy(x, 6, @black)
    end

    @pieces << Rook.new_by_xy(0, 0, @white)
    @pieces << Rook.new_by_xy(7, 0, @white)
    @pieces << Rook.new_by_xy(0, 7, @black)
    @pieces << Rook.new_by_xy(7, 7, @black)
    
    @pieces << Knight.new_by_xy(1, 0, @white)
    @pieces << Knight.new_by_xy(6, 0, @white)
    @pieces << Knight.new_by_xy(1, 7, @black)
    @pieces << Knight.new_by_xy(6, 7, @black)

    @pieces << Bishop.new_by_xy(2, 0, @white)
    @pieces << Bishop.new_by_xy(5, 0, @white)
    @pieces << Bishop.new_by_xy(2, 7, @black)
    @pieces << Bishop.new_by_xy(5, 7, @black)

    @pieces << King.new_by_xy(5, 0, @white)
    @pieces << King.new_by_xy(5, 7, @black)

    @pieces << Queen.new_by_xy(4, 0, @white)
    @pieces << Queen.new_by_xy(4, 7, @black)
  end

  def pieces
    @pieces ||= []
  end

end
