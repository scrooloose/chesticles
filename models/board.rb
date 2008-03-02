class Board
  attr_reader :pieces, :game

  def initialize(game)
    @game = game
    reset
  end

  def reset
    pieces.clear

    0.upto(7) do |x|
      @pieces << Pawn.new_by_xy(x, 1, Player.black, self)
      @pieces << Pawn.new_by_xy(x, 6, Player.white, self)
    end

    @pieces << Rook.new_by_xy(0, 0, Player.black, self)
    @pieces << Rook.new_by_xy(7, 0, Player.black, self)
    @pieces << Rook.new_by_xy(0, 7, Player.white, self)
    @pieces << Rook.new_by_xy(7, 7, Player.white, self)
    
    @pieces << Knight.new_by_xy(1, 0, Player.black, self)
    @pieces << Knight.new_by_xy(6, 0, Player.black, self)
    @pieces << Knight.new_by_xy(1, 7, Player.white, self)
    @pieces << Knight.new_by_xy(6, 7, Player.white, self)

    @pieces << Bishop.new_by_xy(2, 0, Player.black, self)
    @pieces << Bishop.new_by_xy(5, 0, Player.black, self)
    @pieces << Bishop.new_by_xy(2, 7, Player.white, self)
    @pieces << Bishop.new_by_xy(5, 7, Player.white, self)

    @pieces << King.new_by_xy(4, 0, Player.black, self)
    @pieces << King.new_by_xy(4, 7, Player.white, self)

    @pieces << Queen.new_by_xy(3, 0, Player.black, self)
    @pieces << Queen.new_by_xy(3, 7, Player.white, self)
  end

  def pieces
    @pieces ||= []
  end

  def piece_for(square)
    @pieces.find {|p| p.square == square}
  end

  def pieces_for(player)
    @pieces.select {|p| p.player == player}
  end


  def empty?(square)
    piece_for(square).nil?
  end

  def piece_captured(piece)
    pieces.delete(piece)
  end

  def threatened?(square, player)
    !pieces_for(player).find {|p| p.threatening?(square)}.nil?
  end

  def king_for(player)
    pieces.find {|p| p.is_a?(King) && p.player == player}
  end

end
