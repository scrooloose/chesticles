class Rook < Piece
  def legal?(move)
    (move.vertical? || move.horizontal?) && move.clear_path?
  end
end
