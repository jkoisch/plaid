module Plaid
  module Client
    module Logins
      include Plaid::Client::Configurations

      def connect
        body = body_original
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

        handle(response) { PlaidResponse.new(response, "Successful MFA submission - retrieved information from bank", true) }
      end

      def connect_init_user
        body = body_init_user

        response = self.class.post('/connect', :query => body)

        handle(response) { PlaidResponse.new(response, "Successfully added user; Wait on Webhook Response", true) }
      end

      def connect_transaction_followup
        body = body_get_transactions
        response = self.class.post('/connect', :query => body)

        handle(response) { PlaidResponse.new(response, "Successfully retrieved Transactions", true) }
      end

      def connect_filter_response

      end

      def connect_step_specify_mode(mode)
        body = body_mfa_mode(mode)
        response = self.class.post('/connect/step', :query => body)
        handle(response) { PlaidResponse.new(response, "Successful MFA mode submission - retrieved information from bank", true) }
      end

    end

  end

end

