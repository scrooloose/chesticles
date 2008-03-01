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

  private
    def initialize
    end
end
