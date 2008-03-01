class King < Piece
  protected
    def legal_move?(move)
      move.straight? && move.distance == 1
    end
end

