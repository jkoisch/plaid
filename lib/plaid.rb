module Plaid
  class << self
    def configure(&block)
      Plaid::Client::Base.configure(&block)
    end

    def client(user, password, institution)
      Plaid::Client::Base.new(user,password, institution)
    end

    def we_work_with_plaid

    end
  end
end

require 'plaid/client/client'
require 'plaid/client/configuration'
require 'plaid/client/connect'
require 'plaid/plaid_object'
require 'plaid/plaid_error'
require 'plaid/plaid_response'