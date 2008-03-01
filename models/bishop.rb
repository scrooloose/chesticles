class Bishop < Piece
  protected
    def legal_move?(move)
      move.diagonal? && move.clear_path?
    end
end
