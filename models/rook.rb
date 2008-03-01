class Rook < Piece
  protected
    def legal_move?(move)
      (move.vertical? || move.horizontal?) && move.clear_path?
    end
end
