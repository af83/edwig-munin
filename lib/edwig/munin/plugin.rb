module Edwig::Munin
  class Plugin

    def self.create(name)
      camelcase_name = name.split('_').collect(&:capitalize).join
      Edwig::Munin.const_get(camelcase_name).new
    end

    attr_accessor :server, :referential, :token

    def config
      {}
    end

    def values
      {}
    end

    def run(arguments)
      if arguments.first == "config"
        config.each do |key, value|
          puts "#{key} #{value}"
        end
        return
      end

      self.server = ENV['EDWIG_SERVER']
      self.referential = ENV['EDWIG_REFERENTIAL']
      self.token = ENV['EDWIG_TOKEN']

      values.each do |key, value|
        puts "#{key}.value #{value}"
      end
    end

    def env(name, required = false)
      value = ENV[name]
      unless value
	      raise MissingEnv.new "Missing #{name} environment variable"
      end
      value
    end

  end

  class MissingEnv < StandardError; end
end
