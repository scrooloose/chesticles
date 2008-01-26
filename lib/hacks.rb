class String
  class InvalidColorError < StandardError; end

  def color(options = {})
    if options.is_a? Symbol
      options = {:fg => options}
    end

    color = ""
    if options[:fg]
      fg = options[:fg].to_s.upcase
      raise(InvalidColorError, "Invalid foreground color '#{options[:fg]}'") unless HighLine.constants.include?(fg)
      color << HighLine.const_get(fg)
    end

    if options[:bg]
      bg = "ON_#{options[:bg].to_s.upcase}"
      raise(InvalidColorError, "Invalid background color '#{options[:bg]}'") unless HighLine.constants.include?(bg)
      color << HighLine.const_get(bg)
    end

    "#{HighLine::BOLD}#{color}#{self}#{HighLine::RESET}"

  end

end
