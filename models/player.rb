class Player
  class InvalidColorError < StandardError; end

  attr_reader :color

  def initialize(color)
    self.color = color
  end

  def color=(color)
    raise(InvalidColorError, "Invalid color #{color}") unless [:white, :black].include?(color)
    @color = color
  end
end
