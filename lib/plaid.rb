module Plaid
  class << self
    def configure(&block)
      Plaid::Client::Base.configure(&block)
    end

    def client(user, password, institution)
      Plaid::Client::Base.new(user,password, institution)
    end
  end
end

require 'plaid/client/client'
require 'plaid/client/configuration'
require 'plaid/client/connectexit'