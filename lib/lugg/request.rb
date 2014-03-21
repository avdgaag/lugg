require 'time'

module Lugg
  class Request
    attr_reader :source, :hash

    def initialize(source)
      @source = source
      @hash = self.class.hash ^ source.hash
      freeze
    end

    def eql?(other)
      self.class == other.class && source == other.source
    end
    alias_method :==, :eql?

    def method
      source[/^Started ([A-Z]+)/, 1]
    end

    def controller
      source[/^Processing by (\w+)#(\w+) as (\w+)$/, 1]
    end

    def action
      source[/^Processing by (\w+)#(\w+) as (\w+)$/, 1] + '#' +
      source[/^Processing by (\w+)#(\w+) as (\w+)$/, 2]
    end

    def format
      source[/^Processing by (\w+)#(\w+) as (\w+)$/, 3]
    end

    def status
      source[/^Completed (\d+) (\w+)/, 2]
    end

    def code
      source[/^Completed (\d+) (\w+)/, 1].to_i
    end

    def ip
      source[/^Started .* for ([0-9\.]+)/, 1]
    end

    def timestamp
      Time.parse(source[/^Started .* at (.+)$/, 1])
    end

    def uri
      source[/^Started \w+ "([^"]+)"/, 1]
    end

    def path
      uri.split('?').first
    end

    def query
      uri.split('?', 2).last
    end

    def duration
      source[/^Completed .* in (\d+)ms/, 1].to_i
    end

    def params
      params_string = source[/^  Parameters: (.+)$/, 1]
      return {} unless params_string
      eval(params_string) rescue {}
    end
  end
end