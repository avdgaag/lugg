module Lugg
  # RequestMatcher is a flip-flop conditional, that becomes true when compared
  # to one condition, and then stays true until a new condition. It is used to
  # match log entries in a log file, starting to match when encountering a line
  # with `Starting...` and stopping to match when encountering a line with
  # `Completed...`.
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

    def =~(line) # rubocop:disable OpMethod
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
