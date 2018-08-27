require "config/version"

module Config
  class Config
    def initialize(&block)
      #puts block
      instance_eval &block
    end

    def self.build(&block)
      #puts block
      raise ArgumentError, 'Argument is not given' unless block_given?
      Config.new(&block)
    end

    def respond_to_missing?(name)
      instance_variable_defined?("@#{name}".to_sym)
    end

    def method_missing(name, *args, &block)
      # puts 'name'
      # puts name
      # puts 'args'
      # puts args
      if respond_to_missing?(name)
        super
      elsif args[0]
        instance_variable_set("@#{name}".to_sym, args[0]) if args[0]
        self.class.send(:define_method, name, proc { instance_variable_get("@#{name}")})
      else
        Config.build(&block)
      end
    end
  end
end
