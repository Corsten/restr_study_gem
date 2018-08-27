require "config/version"

module Config
  class Config
    def initialize
      puts 'init'
    end

    def self.build(&block)
      raise ArgumentError, 'Argument is not given' unless block_given?
    end
  end
end
