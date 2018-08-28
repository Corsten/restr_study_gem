require "config/version"
require "pry"

module Config
  class Config
    def initialize(&block)
      @data = {}
      instance_eval &block
    end

    def self.build(&block)
      raise ArgumentError, 'Argument or block is not given' unless block_given?
      Config.new(&block)
    end

    def respond_to_missing?(name)
      !@data.key?(name.to_sym)
    end

    def method_missing(name, *args, &block)
      super if args.nil? && block.nil?

      if respond_to_missing?(name)
        self.singleton_class.define_method(name) { |data = @data| return data[name.to_sym] }
        @data[name.to_sym] = args[0] || Config.build(&block)
      end
    end
  end
end
