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
      castling_rook(move).square = castling_rook_new_square(move)
      self.square = move.square
    end

    def castling_rook(move)
      board.piece_for case(move.square)
        when Square.new(2,7): Square.new(0,7)
        when Square.new(6,7): Square.new(7,7)
        when Square.new(2,0): Square.new(0,0)
        when Square.new(6,0): Square.new(7,0)
      end
    end

    def castling_rook_new_square(move)
      case(move.square)
        when Square.new(2,7): Square.new(3,7)
        when Square.new(6,7): Square.new(5,7)
        when Square.new(2,0): Square.new(3,0)
        when Square.new(6,0): Square.new(5,0)
      end
    end
end

