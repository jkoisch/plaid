module Plaid
  module Client
    module Bodies
      include Plaid::Client::Configurations

      # Used before the organization is obtained and chosen by the user
      def body
        {
            :client_id => self.client_id,
            :secret => self.secret
        }
      end

      # the fundamental body object used in most calls to Plaid.
      def body_original
        ret = body
        ret[:type] = self.institution
        ret[:credentials] = {
            "username" => self.username,
            "password" => self.password
        }
        ret[:email] = 'me@example.com'
        ret[:options] = options(nil,"list",true)
        ret
      end

      def body_test
        ret = body_original
        ret[:options] = options(nil,"pretty","true")
        ret
      end

      #simple hash providing the entity_id to plaid.
      def body_entity(entity_id)
        {
          :entity_id => entity_id,
          :options => {"pretty"=>"true"}
        }
      end

      #adds an mfa answer to the body.
      #based on {#body}
      def body_mfa(answer)
        ret = body
        ret[:mfa] = answer.to_s
        ret[:access_token] = self.access_token
        ret[:type] = self.institution
        ret
      end

      #adds a webhook address to {#body_mfa}
      def body_mfa_webhook(answer)
        ret = body_mfa(answer)
        ret[:options] = options(nil,"webhook", webhook_address )
        ret
      end

      def body_mfa_mode(mode)
        ret = body
        ret[:options] = options(nil, "send_method", mode)
        ret[:access_token] = self.access_token
        ret[:type] = self.institution
        ret
      end

      def body_init_user
        ret = body_original
        ret[:options] = options(options(nil,"login",true),"webhook",webhook_address )
        ret
      end

      def body_get_transactions
        body_original
      end

      #helper method to add options to an option hash
      def options(original_hash=nil, key, value)
        if original_hash.nil?
          h = Hash.new
        else
          h = original_hash
        end
        h[key] = value
        h
      end
    end
  end
end
