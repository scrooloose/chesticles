class Move
  class InvalidDestinationSquareError < StandardError; end
  attr_reader :piece, :square

  def initialize(piece, square)
    @piece = piece
    @square = square

    raise(InvalidDestinationSquareError, "Cant move to same square") if square == piece.square
  end

  def to_occupied_square?
    !board.piece_for(square).nil?
  end

  def horizontal?
    dy_for_player == 0 && dx_for_player != 0
  end

  def vertical?
    dy_for_player != 0 && dx_for_player == 0
  end

  def diagonal?
    dy_for_player == dx_for_player
  end

  def forward?
    dy_for_player > 0
  end

  def backward?
    dy_for_player < 0
  end

  def left?
    dx_for_player < 0
  end

  def right?
    dx_for_player > 0
  end

  def dy_for_player
    @ydelta ||= begin
      ydelta = start_square.y_delta_to(square)
      ydelta = -ydelta if player.white?
      ydelta
    end
  end

  def dx_for_player
    @xdelta ||= begin
      xdelta = start_square.x_delta_to(square)
      xdelta = -xdelta if player.black?
      xdelta
    end
  end

  def distance
    @distance ||= piece.square.distance_to(square)
  end

  def start_square
    piece.square
  end

  private
    def player
      piece.player
    end

    def board
      piece.board
    end
end
