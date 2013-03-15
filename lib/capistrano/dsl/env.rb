module Capistrano
  module DSL
    module Env

      def configure_backend
        env.configure_backend
      end

      def fetch(key, default=nil)
        env.fetch(key, default)
      end

      def set(key, value)
        env.set(key, value)
      end

      def ask(key, value)
        env.ask(key, value)
      end

      def role(name, servers)
        env.role(name, servers)
      end

      def roles(*names)
        env.roles_for(names)
      end

      def all
        env.all_roles
      end

      def env
        Configuration.env
      end

      def release_timestamp
        env.timestamp.strftime("%Y%m%d%H%M%S")
      end

      def asset_timestamp
        env.timestamp.strftime("%Y%m%d%H%M.%S")
      end

    end
  end
end

