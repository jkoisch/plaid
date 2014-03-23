module Plaid
  module Client
    module Balances
      include Plaid::Client::Configurations

      def get_balance
        body = body_retrieve

        response = self.class.get('/balance', :query => body)
        handle(response) { PlaidResponse.new(response, "Retrieved Balance") }
      end

    end
  end
end
