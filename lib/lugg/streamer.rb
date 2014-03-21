require 'lugg/request'
require 'lugg/request_matcher'

module Lugg
  class Streamer
    attr_reader :io
    private :io

    def initialize(io)
      @io = io
    end

    def records
      Enumerator.new do |yielder|
        buffer = ''
        matcher = RequestMatcher.new
        io.each do |line|
          buffer << line if matcher =~ line
          if matcher.finished?
            yielder << Request.new(buffer)
            matcher = RequestMatcher.new
            buffer = ''
          end
        end
      end
    end
  end
end
