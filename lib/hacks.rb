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

class Numeric
  def even?
    self % 2 == 0    
  end

  def odd?
    self % 2 == 1    
  end
end

class Object
  def delegate(*methods)
    options = methods.pop
    if options.is_a?(Hash) && options[:to].nil?
        raise(ArgumentError, "Must specify a target for the delegation with :to, eg delegate(:foo, :to => :bar)")
    end

    methods.each do |method| 
      define_method(method) do
        send(options[:to]).send(method)
      end
    end
  end
end
