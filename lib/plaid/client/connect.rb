module Plaid
  module Client
    module Logins
      include Plaid::Client::Configurations

      def connect
        body = body_user

        response = self.class.post('/connect', :query => body)

        if response.code.eql? 200
          PlaidObject.new(response.parsed_response)
          # todo self.access_token =
        else
          PlaidError.new(response)
        end
      end

    end

  end

end

