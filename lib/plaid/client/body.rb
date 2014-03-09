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
        ret[:options]= {"pretty"=>"true"}
        ret
      end
    end
  end
end
