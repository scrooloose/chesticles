class Queen < Piece
  protected
    def legal_move?(move)
      move.straight? && move.clear_path?
    end
end
