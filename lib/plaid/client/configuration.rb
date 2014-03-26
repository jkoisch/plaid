module Plaid
  module Client
    module Configurations
      require 'active_support/concern'
      extend ActiveSupport::Concern

      included do
        #Plaid.com
        add_config :endpoint
        add_config :headers

        #app
        add_config :certpath
        add_config :client_id
        add_config :secret
        add_config :webhook_address
        add_config :save_full_response

        # set default values
        reset_config
      end

      module ClassMethods

        def add_config(name)
          class_eval <<-RUBY, __FILE__, __LINE__ + 1

              def self.#{name}(value=nil)
                @#{name} = value if value
                return @#{name} if self.object_id == #{self.object_id} || defined?(@#{name})
                name = superclass.#{name}
                return nil if name.nil? && !instance_variable_defined?("@#{name}")
                @#{name} = name && !name.is_a?(Module) && !name.is_a?(Symbol) && !name.is_a?(Numeric) && !name.is_a?(TrueClass) && !name.is_a?(FalseClass) ? name.dup : name
              end

              def self.#{name}=(value)
                @#{name} = value
              end

              def #{name}=(value)
                @#{name} = value
              end

              def #{name}
                value = @#{name} if instance_variable_defined?(:@#{name})
                value = self.class.#{name} unless instance_variable_defined?(:@#{name})
                if value.instance_of?(Proc)
                  value.arity >= 1 ? value.call(self) : value.call
                else
                  value
                end
              end
          RUBY
        end

        def configure
          yield self
        end

        ##
        # sets configuration to defaults
        # These will probably cause your application to fail, and you should change them.
        #
        def reset_config
          configure do |config|

            config.client_id            = 'JUNK'
            config.secret               = 'JUNK'
            config.endpoint             = 'https://tartan.plaid.com/'
            config.certpath             = 'ca-bundle.crt'
            config.headers              = {'Content-Type'=>'application/x-www-form-urlencoded'}
            config.webhook_address      = 'http://domain.com/plaid_webhook/antennas'
            config.save_full_response   = true

          end
        end
      end
    end
  end
end
