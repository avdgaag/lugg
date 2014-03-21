module Lugg
  # Apply a list of filters to an Enumerable object or an enumerator.
  #
  # This class is used to combine all the search queries into a single filter
  # to process a collection with. Its input is expected to be a
  # `Lugg::Streamer` enumerator, but it could be anything.
  #
  # By default, the collection will be passed through as-is, but you can add
  # more conditions to limit the results with either callable objects (such as
  # Procs) or with blocks.
  #
  # @example Using a proc
  #   filter = Filter.new
  #   filter.use ->(record) { record.method == 'GET' }
  #
  # @example Using a block
  #   filter = Filter.new
  #   filter.use { |record| record.code == 404 }
  class Filter
    def initialize
      @conditions = []
    end

    # Apply all known conditions to `records`.
    #
    # @param [Enumerable] records
    # @return [Enumerable] filtered records
    def call(records)
      return records unless @conditions.any?
      records.select do |record|
        matches?(record)
      end
    end

    # Store a new condition to be used on the next invocation of {#call}.
    #
    # @param [#call] callable
    # @raise ArgumentError when both a callable or block are given
    # @raise ArgumentError when the given callable does not respond to #call
    def use(callable = nil, &block)
      unless block_given? ^ callable
        raise ArgumentError, 'Supply either an argument or a block'
      end

      unless block_given? || callable.respond_to?(:call)
        raise ArgumentError, 'Supply either a callable argument or a block'
      end

      @conditions << (block_given? ? block : callable)
    end

    private

    def matches?(record)
      @conditions.any? do |condition|
        condition.call(record)
      end
    end
  end
end
