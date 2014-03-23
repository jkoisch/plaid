module Plaid
  module Client

    class Base
      attr_accessor :mfa_response, :mfa_type, :mfa_message, :username, :password, :institution, :endpoint, :secret, :access_token, :is_mfa_initialized, :email

      require 'plaid/client/configuration'
      require 'plaid/client/connect'
      require 'plaid/client/body'
      require 'plaid/plaid_object'
      require 'plaid/plaid_error'
      require 'plaid/plaid_response'
      require 'httparty'
      include Plaid::Client::Configurations
      include Plaid::Client::Logins
      include Plaid::Client::Bodies
      include HTTParty

      base_uri endpoint
      format :json
      ssl_ca_file certpath
      ssl_version :SSLv3
      debug_output $stdout

      def initialize(user, e_mail, pass_word, institution)
        self.username = user
        self.email = e_mail
        self.password = pass_word
        self.institution = institution
        self.mfa_response ||= []
      end

      def settings
        puts "Base URI: " + endpoint.to_s
        puts "Cert: " + certpath.to_s
        puts "User: " + self.username.to_s
        puts "Email: " + self.email.to_s
        puts "Plaid Client_id: " + self.client_id.to_s
        puts "Webhook address: " + webhook_address
        puts "Save full response: " + save_full_response.to_s
      end

      #generic method for handling the structure of the response. Only creates an error object if there is an error (business error) from Plaid.com. Yields to the block with calling function
      def handle(response)
        if response.code.eql? 200
          self.mfa_type = nil
          self.mfa_message = nil
          self.is_mfa_initialized = false
          yield(response)
        elsif response.code.eql? 201        #mfa
          mfa_201 = PlaidResponse.new(response, "MFA")
          self.access_token = mfa_201.access_token
          self.mfa_type = mfa_201.raw_response.type
          self.mfa_response << mfa_201
          self.mfa_message = mfa_201.message
          self.is_mfa_initialized = mfa_201.is_mfa?
          mfa_201
        else
          PlaidError.new(response, "Error")
        end
      end

      #for testing through IRB
      def secrets(client_id, secret)
        self.client_id = client_id
        self.secret = secret
        "Set"
      end

      def is_mfa?
        @is_mfa_initialized
      end

      def plaid_response_codes
        {
            200 => "Success",
          201 => "MFA Required",
          400 => "Bad Request",
          401 => "Unauthorized",
          402 => "Request Failed",
          404 => "Cannot be Found",
          500 => "Server Error"
        }
      end
    end

  end

end