module Plaid
  module Client
    module Logins
      include Plaid::Client::Configurations

      def connect
        body = body_user
        response = self.class.post('/connect', :query => body)

        handle(response) do |r|
          plaid = PlaidResponse.new(r, "Successful retrieved information from bank", true)
          self.access_token = plaid.access_token
          plaid
        end
      end

      def connect_step(mfa_response)
        body = body_mfa(mfa_response)
        response = self.class.post('/connect/step', :query => body)

        handle(response) { PlaidResponse.new(response, "Successful MFA submission - retrieved information from bank",
                                             true) }

      end

    end

  end

end

