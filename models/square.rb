class Square
  class InvalidCoordinateError < StandardError; end

  attr_reader :x, :y

  def initialize(x, y)
    self.x = x
    self.y = y
  end

  def x=(x)
    raise(InvalidCoordinateError, "invalid X coord: #{x}") if x < 0 || x > 7
    @x = x
  end

  def y=(y)
    raise(InvalidCoordinateError, "invalid Y coord: #{y}") if y < 0 || y > 7
    @y = y
  end
end
