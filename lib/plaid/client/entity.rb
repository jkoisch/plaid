module Plaid
  module Client
    module Entities
      include Plaid::Client::Configurations

      def get_entity(entity_id)
        body = body_entity(entity_id)

        response = self.class.get('/entity', :query => body)

        handle(response) { PlaidResponse.new(response, "Retrieved Entity", save_full_response)}
      end

    end
  end
end
