require "config/version"
require "pry"

module Config
  class Config
    def initialize(&block)
      @hash = {}
      instance_eval &block
    end

    def self.build(&block)
      raise ArgumentError, 'Argument is not given' unless block_given?
      Config.new(&block)
    end

    def respond_to_missing?(name)
      @hash.key?(name.to_sym)
    end

    def method_missing(name, *args, &block)
      if !respond_to_missing?(name) && args[0]
        @hash[name.to_sym] = args[0]
        define_singleton_method(name) do |hash = @hash|
          hash[name.to_sym]
        end
      elsif !block.nil?
        define_singleton_method(name) do |hash = @hash|
          hash[name.to_sym]
        end
        @hash[name.to_sym] = Config.build(&block)
      else
        super
      end
    end
  end
end
