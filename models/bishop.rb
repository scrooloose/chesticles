class Bishop < Piece
  def legal?(move)
    move.diagonal? && move.clear_path?
  end
end
