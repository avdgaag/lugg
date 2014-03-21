module Lugg
  class RequestMatcher
    def initialize
      @active = false
      @finished = false
    end

    def active?
      !!@active
    end

    def finished?
      !!@finished
    end

    def =~(line)
      if line =~ /^Started/
        @active = true
      elsif line =~ /^Completed/
        @active = false
        @finished = true
      else
        @active
      end
    end
  end
end
