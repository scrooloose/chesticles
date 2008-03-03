class Square
  class InvalidCoordinateError < StandardError; end
  class InvalidOperationError < StandardError; end

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

  def black?
    x.even? != y.even?
  end

  def white?
    x.even? == y.even?
  end

  def ==(s)
    x == s.x && y == s.y
  end

  def x_delta_to(s)
    s.x - x
  end

  def y_delta_to(s)
    s.y - y
  end

  def to_s
    "(#{x}, #{y})"
  end

  def squares_between(dest)
    dx = x_delta_to(dest)
    dy = y_delta_to(dest)

    unless dx == 0 || dy == 0 || dx.abs == dy.abs
      raise(InvalidOperationError, "can only find the squares between a square in a straight line")
    end

    min_x = x < dest.x ? x : dest.x
    max_x = x > dest.x ? x : dest.x
    min_y = y < dest.y ? y : dest.y
    max_y = y > dest.y ? y : dest.y

    if dy == 0 #horizontal line 
      return ((min_x+1)..(max_x-1)).map {|x| Square.new(x, self.y)}
    elsif dx == 0 #vertical line
      return ((min_y+1)..(max_y-1)).map {|y| Square.new(self.x, y)}
    else #diagonal line 
      xdiff = dest.x - self.x 
      ydiff = dest.y - self.y 

      #there are no between squares 
      return [] if xdiff == 1

      xstep = xdiff / xdiff.abs
      ystep = ydiff / ydiff.abs

      squares = []
      x = self.x + xstep
      y = self.y + ystep
      while x != dest.x && y != dest.y
        squares << Square.new(x, y)
        x += xstep
        y += ystep
      end

      return squares
    end
  end

end
