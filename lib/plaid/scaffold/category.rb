module Plaid
  module Scaffold
    module Categories

      module ClassMethods
        def get_category(id)
          response = self.get('/categories/' + id.to_s)
          PlaidObject.new(response)
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end