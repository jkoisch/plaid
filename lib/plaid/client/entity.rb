module Plaid
  module Client
    module Entities
      include Plaid::Client::Configurations

      def get(entity_id)
        body = body_entity(entity_id)

        response = self.class.get('/entity', :query => body)

        if response.code.eql? 200
          PlaidObject.new(response.parsed_response)
        else
          PlaidResponse.new(response, response)
        end
      end

    end
  end
end
