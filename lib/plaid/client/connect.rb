module Plaid
  module Client
    module Logins
      include Plaid::Client::Configurations

      def connect
        body = body_org
        session_token = Hash.new

        response = self.class.post('/Login.json', :query => body,:headers => headers)

        if response["response_message"].eql? "Success"
          session_token[:session_id] = response["response_data"]["sessionId"]
          session_token[:temp_endpoint] = response["response_data"]["apiEndPoint"]
        else
          PlaidResponse.new(response, response)
        end
        session_token
      end

    end

  end

end

