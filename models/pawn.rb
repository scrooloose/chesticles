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
    [:forward_left, :forward_right].include?(move.direction) && move.to_occupied_square?
  end
end
