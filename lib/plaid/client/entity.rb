module Plaid
  module Client
    module Entities
      include Plaid::Client::Configurations

      def get_entity(entity_id)
        body = body_entity(entity_id)

        response = self.class.get('/entity', :query => body)

        handle(response) { PlaidResponse.new(response, "Retrieved Entity")}
      end

    end
  end
end
