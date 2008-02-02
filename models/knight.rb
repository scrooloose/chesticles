class Knight < Piece
  def legal?(move)
    dx = move.dx.abs
    dy = move.dy.abs
    (dx == 2 && dy == 1) || (dx == 1 && dy == 2)
  end
end

