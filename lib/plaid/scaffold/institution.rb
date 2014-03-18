module Plaid
  module Scaffold
    module Institutions

      module ClassMethods
        def index_institutions
          ret = []
          response = self.get('/institutions')
          response.each do |piece|
            ret << PlaidObject.new(piece)
          end
          self.institutions = ret
        end

        def get_institution(id)
          response = self.get('/institutions/' + id.to_s)
          PlaidObject.new(response)
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end