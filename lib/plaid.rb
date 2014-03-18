module Plaid
  class << self
    def configure(&block)
      Plaid::Client::Base.configure(&block)
    end

    def client(user, password, institution)
      Plaid::Client::Base.new(user,password, institution)
    end

    def scaffold
      Plaid::Scaffold::Base
    end
  end
end

require 'plaid/client/client'
require 'plaid/client/configuration'
require 'plaid/client/connect'
require 'plaid/client/entity'
require 'plaid/scaffold/scaffold'
require 'plaid/scaffold/institution'
require 'plaid/plaid_object'
require 'plaid/plaid_error'
require 'plaid/plaid_response'