module Lugg
  class Filter
    def initialize
      @conditions = []
    end

    def call(records)
      return records unless @conditions.any?
      records.select do |record|
        matches?(record)
      end
    end

    def use(callable = nil, &block)
      unless block_given? ^ callable
        raise ArgumentError, 'Supply either an argument or a block'
      end

      unless block_given? || callable.respond_to?(:call)
        raise ArgumentError, 'Supply either a callable argument or a block'
      end

      if block_given?
        @conditions << block
      else
        @conditions << callable
      end
    end

    private

    def matches?(record)
      @conditions.any? do |condition|
        condition.call(record)
      end
    end
  end
end
