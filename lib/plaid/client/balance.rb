module Plaid
  module Client
    module Balances
      include Plaid::Client::Configurations

      def get_balance
        body = body_retrieve

        response = self.class.get('/balance', :query => body)
        handle(response) { PlaidResponse.new(response, "Retrieved Balance", save_full_response)}
      end

    end
  end
end
