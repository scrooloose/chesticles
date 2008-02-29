module TestBoards
  def boards(sym)
    case sym
    when :start: Board.new
    end
  end
end
