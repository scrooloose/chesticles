class King < Piece
  def move(m)
    if m.castle?
      self.castle(m)
    else
      super
    end
  end

  protected
    def legal_move?(move)
      move.straight? && move.distance == 1
    end

    def castle(move)
      rook_square = if move.direction?(:left)
        white? ? Square.new(0,7) : Square.new(7,0)
      else 
        white? ? Square.new(7,7) : Square.new(0,0)
      end
      rook = board.piece_for(rook_square)

      new_rook_square = if move.direction?(:left)
        white? ? Square.new(3,7) : Square.new(5,0)
      else 
        white? ? Square.new(5,7) : Square.new(3,0)
      end
      rook.square = new_rook_square
      self.square = move.square
    end

end

