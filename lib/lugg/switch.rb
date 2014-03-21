module Lugg
  # An object representing a command line swith with certain behaviour. The
  # Runner applies switches to its own internal `OptionParser` object to build
  # the CLI and provide querying functionality.
  #
  # @see Runner
  class Switch
    @queries = []

    # Define a new Switch object and add it to the global collection of
    # switches.
    def self.define(*args, &block)
      @queries << new(*args).tap { |obj| obj.instance_eval(&block) }
    end

    # Call {#apply} on each {Switch} in the global collection to register the
    # callback on a given object.
    def self.apply_all(*args)
      @queries.each do |query|
        query.apply_to(*args)
      end
    end

    def initialize(method = :on)
      @method = method
      @flags  = nil
      @cast   = nil
      @desc   = nil
      @action = nil
    end

    def apply_to(options, obj)
      @options = options
      @obj     = obj
      @options.send(@method, *[@flags, @cast, @desc].flatten.compact, &@action)
    end

    attr_reader :options, :obj

    private

    def flags(*flags)
      @flags = flags
    end

    def cast(obj)
      @cast = obj
    end

    def desc(msg)
      @desc = msg
    end

    def action(&block)
      @action = block
    end
  end
end
