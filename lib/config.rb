require 'config/version'

module Config
  #Make hash and method for work with them from block
  class Config
    def initialize(&block)
      @data = {}
      instance_eval(&block)
    end

    def self.build(&block)
      raise ArgumentError, 'Argument or block is not given' unless block_given?
      Config.new(&block)
    end

    def respond_to_missing?(name)
      !@data.key?(name.to_sym)
    end

    def method_missing(name, *args, &block)
      super if args[0].nil? && block.nil?

      return unless respond_to_missing?(name)

      singleton_class.define_method(name) { |data = @data| data[name.to_sym] }
      @data[name.to_sym] = args[0] || Config.build(&block)
    end
  end
end
