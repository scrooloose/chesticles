class King < Piece
  def legal?(move)
    move.straight? && move.distance == 1
  end

  
end

