require_relative 'configuration/question'
require_relative 'configuration/servers'
require_relative 'configuration/server'

module Capistrano
  class Configuration

    class << self
      def env
        @env ||= new
      end
    end

    def ask(key, default=nil)
      question = Question.new(self, key, default)
      set(key, question)
    end

    def set(key, value)
      config[key] = value
    end

    def fetch(key, default=nil, &block)
      value = fetch_for(key, default, &block)
      if value.respond_to?(:call)
        set(key, value.call)
      else
        value
      end
    end

    def role(name, hosts)
      servers.add_role(name, hosts)
    end

    def server(name, properties = {})
      servers.add_host(name, properties)
    end

    def roles_for(names, options = {})
      servers.fetch_roles(names).tap do |list|
        if filter = options.delete(:filter) || options.delete(:select)
          if filter.respond_to?(:call)
            list.select!(&filter)
          else
            list.select! { |s| s.properties.send(filter) }
          end
          if list.empty?
            raise "Your filter #{filter} would remove all matching servers!"
          end
        end
      end
    end

    def primary(role)
      servers.fetch_primary(role)
    end

    def configure_backend
      SSHKit.configure do |sshkit|
        sshkit.format           = fetch(:format)
        sshkit.output_verbosity = fetch(:log_level)
        sshkit.default_env      = fetch(:default_env)
        sshkit.backend.configure do |backend|
          backend.pty                = fetch(:pty)
          backend.connection_timeout = fetch(:connection_timeout)
        end
      end
    end

    def timestamp
      @timestamp ||= Time.now.utc
    end

    private

    def servers
      @servers ||= Servers.new
    end

    def config
      @config ||= Hash.new
    end

    def fetch_for(key, default, &block)
      if block_given?
        config.fetch(key, &block)
      else
        config.fetch(key, default)
      end
    end

  end
end
