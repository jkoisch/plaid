module Plaid
  module Client
    module Logins
      include Plaid::Client::Configurations

      #connects to the plaid api.
      #this can be used to retrieve information, get the access token, and initialize a user.
      #sets the access token on the {Plaid::Client::Base}
      #@return {PlaidResponse}
      def connect
        body = body_original
        response = self.class.post('/connect', :query => body)

        handle(response) do |r|
          plaid = PlaidResponse.new(r, "Successful retrieved information from bank", save_full_response)
          self.access_token = plaid.access_token
          plaid
        end
      end

      #The basic way to submit MFA information to Plaid.
      #Simply appends the answer into the parameters for submission.
      #@return {PlaidResponse} or {PlaidError}
      def connect_step(mfa_response)
        body = body_mfa(mfa_response)
        response = self.class.post('/connect/step', :query => body)

        handle(response) { PlaidResponse.new(response, "Successful MFA submission - retrieved information from bank", save_full_response) }
      end

      #Submits an MFA answer to Plaid.
      #Adds a webhook return address as a parameter.
      #@return {PlaidResponse} or {PlaidError}
      def connect_step_webhook(mfa_response)
        body = body_mfa_webhook(mfa_response)
        response = self.class.post('/connect/step', :query => body)

        handle(response) { PlaidResponse.new(response, "Successful MFA submission - Webhook will notify when retrieved information from bank", save_full_response) }
      end

      # Plaid's preferred way to initialize a user to their bank via the Plaid Proxy.
      #
      def connect_init_user
        body = body_init_user

        response = self.class.post('/connect', :query => body)

        handle(response) { PlaidResponse.new(response, "Successfully added user; Wait on Webhook Response", save_full_response) }
      end

      def connect_transaction_followup
        body = body_retrieve
        response = self.class.post('/connect', :query => body)

        handle(response) { PlaidResponse.new(response, "Successfully retrieved Transactions", save_full_response) }
      end

      def connect_filter_response

      end

      def connect_step_specify_mode(mode)
        body = body_mfa_mode_webhook(mode)
        response = self.class.post('/connect/step', :query => body)
        handle(response) { PlaidResponse.new(response, "Successful MFA mode submission - retrieved information from bank", save_full_response) }
      end

    end

  end

end

