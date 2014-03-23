module Plaid
  module Client
    module Followups
      include Plaid::Client::Configurations

      #explicitly for following up after an init to retrieve updated information from Plaid
      def followup
        body = body_retrieve
        response = self.class.get('/connect', :query => body)

        handle(response) { PlaidResponse.new(response, "Successfully retrieved Transactions") }
      end
    end
  end
end
