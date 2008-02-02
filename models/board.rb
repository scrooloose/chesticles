class Board
  attr_reader :pieces, :white, :black

  def initialize(white, black)
    @white = white
    @black = black
    reset
  end

  def reset
    pieces.clear

    0.upto(7) do |x|
      @pieces << Pawn.new_by_xy(x, 1, @black, self)
      @pieces << Pawn.new_by_xy(x, 6, @white, self)
    end

    @pieces << Rook.new_by_xy(0, 0, @black, self)
    @pieces << Rook.new_by_xy(7, 0, @black, self)
    @pieces << Rook.new_by_xy(0, 7, @white, self)
    @pieces << Rook.new_by_xy(7, 7, @white, self)
    
    @pieces << Knight.new_by_xy(1, 0, @black, self)
    @pieces << Knight.new_by_xy(6, 0, @black, self)
    @pieces << Knight.new_by_xy(1, 7, @white, self)
    @pieces << Knight.new_by_xy(6, 7, @white, self)

    @pieces << Bishop.new_by_xy(2, 0, @black, self)
    @pieces << Bishop.new_by_xy(5, 0, @black, self)
    @pieces << Bishop.new_by_xy(2, 7, @white, self)
    @pieces << Bishop.new_by_xy(5, 7, @white, self)

    @pieces << King.new_by_xy(4, 0, @black, self)
    @pieces << King.new_by_xy(4, 7, @white, self)

    @pieces << Queen.new_by_xy(3, 0, @black, self)
    @pieces << Queen.new_by_xy(3, 7, @white, self)
  end

  def pieces
    @pieces ||= []
  end

  def piece_for(square)
    @pieces.find {|p| p.square == square}
  end

  def empty?(square)
    piece_for(square).nil?
  end

  def piece_captured(piece)
    pieces.delete(piece)
  end



end
