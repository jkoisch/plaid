module Plaid
  module Client

    class ThinClient
      attr_accessor :institution, :endpoint, :secret, :access_token, :email, :client_id

      require 'plaid/client/configuration'
      require 'plaid/client/followup'
      require 'plaid/client/entity'
      require 'plaid/client/balance'
      require 'plaid/client/body'
      require 'plaid/plaid_object'
      require 'plaid/plaid_error'
      require 'plaid/plaid_response'
      require 'httparty'
      include Plaid::Client::Configurations
      include Plaid::Client::Bodies
      include Plaid::Client::Entities
      include Plaid::Client::Balances
      include Plaid::Client::Followups
      include HTTParty

      base_uri endpoint
      format :json
      ssl_ca_file certpath
      ssl_version :SSLv3
      debug_output $stdout

      def initialize(e_mail, institution, access_token)
        self.email = e_mail
        self.institution = institution
        self.access_token = access_token
      end

      #for testing through IRB
      def secrets(client_id, secret)
        self.client_id = client_id
        self.secret = secret
        "Set"
      end

      def settings
        puts "Base URI: " + endpoint.to_s
        puts "Cert: " + certpath.to_s
        puts "Email: " + self.email.to_s
        puts "Plaid Client_id: " + self.client_id.to_s
        puts "Webhook address: " + webhook_address
        puts "Save full response: " + save_full_response.to_s
      end

      #generic method for handling the structure of the response. Only creates an error object if there is an error (business error) from Plaid.com. Yields to the block with calling function
      def handle(response)
        if response.code.eql? 200
          yield(response) if block_given?
        else
          PlaidError.new(response, "Error")
        end
      end
    end
  end
end