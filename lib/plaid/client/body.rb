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

      # For accessing balances associated with an access_token
      # * client_id
      # * secret
      # * access_token
      def body_retrieve
        ret = Hash.new
        ret[:access_token] = self.access_token
        ret.merge(body)
      end

      # the fundamental body object used in most calls to Plaid.
      # * client_id
      # * secret
      # * institution_type
      # * credentials
      # * email
      # * options {"list":true}
      def body_original
        ret = Hash.new
        ret[:type] = self.institution
        ret[:credentials] = {
            "username" => self.username,
            "password" => self.password
        }
        ret[:email] = 'me@example.com'
        ret[:options] = options(nil,"list",true)
        ret.merge(body)
      end

      def body_test
        ret = hash.new
        ret[:options] = options(nil,"pretty","true")
        ret.merge(body_original)
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
        ret = Hash.new
        ret[:mfa] = answer.to_s
        ret[:access_token] = self.access_token
        ret[:type] = self.institution
        ret.merge(body)
      end

      #adds a webhook address to {#body_mfa}
      def body_mfa_webhook(answer)
        ret = Hash.new
        ret[:options] = options(nil,"webhook", webhook_address )
        ret.merge(body_mfa(answer))
      end

      def body_mfa_mode(mode)
        ret = Hash.new
        ret[:options] = options(nil, "send_method", mode)
        ret[:access_token] = self.access_token
        ret[:type] = self.institution
        ret.merge(body)
      end

      def body_init_user
        ret = Hash.new
        ret[:options] = options(options(nil,"login",true),"webhook",webhook_address )
        ret.merge(body_original)
      end

      def body_get_transactions
        body_retrieve
      end

      #helper method to add options to an option hash
      def options(original_hash=nil, key, value)
        j = Hash.new
        j[key] = value
        j.merge(original_hash) unless original_hash.nil?
        j
      end
    end
  end
end
