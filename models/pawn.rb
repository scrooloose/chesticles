class Pawn < Piece
  def move(move)
    super(move)
    @moved = true
  end

  def moved?
    @moved 
  end

  def legal?(move)
    if move.direction?(:forward) && move.to_empty_square?
      return true if move.distance == 1
      return true if move.distance == 2 && !moved? && move.clear_path?
    end

    #check if we are taking a piece 
    [:forward_left, :forward_right].include?(move.direction) && move.to_enemy_occupied_square?
  end

  def threatening?(square)
    m = move_for(square)
    legal?(m) || m.direction?(:forward_left, 1) || m.direction?(:forward_right, 1)
  end

end
