module BoardHelpers
  def boards(sym)
    case sym
    when :start: Board.new(Game.new)
    end
  end
end
