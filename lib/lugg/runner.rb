require 'lugg/version'
require 'lugg/filter'
require 'lugg/streamer'
require 'lugg/switches'
require 'optparse'
require 'optparse/time'

module Lugg
  # The runner defines the command line interface for Lugg, using the other
  # components and defining command line options and their implementations.
  #
  # When creating a Runner object, you pass it your option flags (typically
  # `ARGV`). You can then apply its conditions to an IO object (typically
  # `ARGF`).
  #
  # @todo extract conditions into individual objects.
  class Runner
    attr_reader :filter
    private :filter

    def initialize(flags = [], filter = Filter.new)
      @filter = filter
      reset
      options.parse!(flags)
    end

    def run(io)
      filter.call(Streamer.new(io).records).each do |request|
        puts request.source
      end
    end

    def add_clause(&block)
      if combine_clauses?
        prev_block = @last_block
        filter.use { |r| prev_block.call(r) && block.call(r) }
        reset
      else
        filter.use(&block)
        @last_block = block
      end
    end

    def combine_next
      @combine = true
    end

    private

    def options
      @options ||= OptionParser.new do |o|
        o.banner = <<-EOS
Usage: lugg [options] FILE

Parses log entries from FILE or STDIN and uses [options] to control what is
sent STDOUT.
EOS
        o.separator ''
        Switch.apply_all(o, self)
      end
    end

    def reset
      @combine = false
      @last_block = nil
    end

    def combine_clauses?
      @combine && @last_block
    end
  end
end
