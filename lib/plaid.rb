module Plaid
  class << self
    def configure(&block)
      Plaid::Client::Base.configure(&block)
      Plaid::Client::ThinClient.configure(&block)
    end

    # client for initializing access through Plaid
    def client(user, email, password, institution)
      Plaid::Client::Base.new(user, email, password, institution)
    end

    # a special thin client for accessing Plaid without credentials securely
    def thin_client(e_mail, institution, access_token)
      Plaid::Client::ThinClient.new(e_mail, institution, access_token)
    end

    #scaffolding are general purpose tools for dealing with Plaid
    def scaffold
      Plaid::Scaffold::Base
    end
  end
end

require 'plaid/client/client'
require 'plaid/client/thin_client'
require 'plaid/client/configuration'
require 'plaid/client/connect'
require 'plaid/client/entity'
require 'plaid/client/balance'
require 'plaid/client/followup'
require 'plaid/scaffold/scaffold'
require 'plaid/scaffold/institution'
require 'plaid/plaid_object'
require 'plaid/plaid_error'
require 'plaid/plaid_response'