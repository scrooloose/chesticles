class Pawn < Piece
  def move(move)
    super(move)
    if move.moving_to_end_of_board?
      board.pieces.delete(self)
      board.pieces << Queen.new(square, player, board)
    end
  end

  def threatening?(square)
    m = Move.new(self, square)
    passes_basic_checks?(m) && (m.direction?(:forward_left, 1) || m.direction?(:forward_right, 1))
  rescue Move::InvalidDestinationSquareError
    false
  end

  protected
  def legal_move?(move)
    if move.direction?(:forward) && move.to_empty_square?
      return true if move.distance == 1
      return true if move.distance == 2 && !moved? && move.clear_path?
    end

    #check if we are taking a piece 
    [:forward_left, :forward_right].include?(move.direction) && move.to_enemy_occupied_square?
  end
end
