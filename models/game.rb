class Game
  attr_reader :board, :current_player

  def initialize
    @current_player = Player.white
    @board = Board.new(self)
  end

  def whites_turn?
    @current_player == Player.white    
  end

  def blacks_turn?
    @current_player == Player.black    
  end

  def toggle_turn
    @current_player = if @current_player.black?
      Player.white
    else
      Player.black
    end
  end

end
