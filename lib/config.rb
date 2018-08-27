require "config/version"

module Config
  class Config
    def initialize(&block)
      instance_eval &block
    end

    def self.build(&block)
      raise ArgumentError, 'Argument is not given' unless block_given?
      Config.new(&block)
    end

    def respond_to_missing?(name, *args)
      instance_variable_defined?("@#{name}".to_sym)
    end

    def method_missing(name, *args, &block)
      if respond_to_missing?(name, *args)
        super
      else
        instance_variable_set("@#{name}".to_sym, args[0])
        self.class.send(:define_method, name, proc { instance_variable_get("@#{name}")})
      end
    end
  end
end
