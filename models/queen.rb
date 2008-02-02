class Queen < Piece
  def legal?(move)
    move.straight? && move.clear_path?
  end

end
