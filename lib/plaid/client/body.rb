module Plaid
  module Client
    module Bodies
      # Used before the organization is obtained and chosen by the user
      def body
        {
            :client_id => self.client_id,
            :secret => self.secret
        }
      end

      def body_user
        ret = body
        ret[:type] = self.institution
        ret[:credentials] = {
            "username" => self.username,
            "password" => self.password
        }
        ret[:email] = 'me@example.com'
        ret
      end

      def body_test
        ret = body_user
        ret[:options] = {"pretty"=>"true"}
        ret
      end

      def body_entity(entity_id)
        {
          :entity_id => entity_id,
          :options => {"pretty"=>"true"}
        }
      end

      def body_mfa(answer)
        ret = body
        ret[:mfa] = answer.to_s
        ret[:access_token] = self.access_token
        ret
      end

      def body_init_user
        ret = body_user
        options_hash = {
          'webhook' => 'http://stage.worx.io/plaid_webhook/antennas',
          'login' => true
        }
        ret[:options] = options_hash
        ret
      end

      def body_get_transactions
        body_user
      end
    end
  end
end
