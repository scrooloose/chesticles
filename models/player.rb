class Player
  def black?
    self == Player.black
  end

  def white?
    self == Player.white
  end

  def self.white
    @white ||= new
  end

  def self.black
    @black ||= new
  end

  def enemy
    if white?
      Player.black
    else
      Player.white
    end
  end


  private
    def initialize
    end
end
