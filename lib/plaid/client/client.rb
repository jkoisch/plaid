module Plaid
  module Client

    class Base
      attr_accessor :username, :password, :institution, :client_id, :endpoint, :secret

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

      def initialize(user,pass_word, institution)
        self.username = user
        self.password = pass_word
        self.institution = institution
      end

      def settings
        puts "Base URI: " + endpoint.to_s
        puts "Cert: " + certpath.to_s
        puts "User: " + self.username.to_s
        puts "Plaid Client_id: " + self.client_id.to_s
      end

      def token(hash)
        unless hash[:session_id].blank?
          self.session_id = hash[:session_id]
          self.temp_endpoint = hash[:temp_endpoint]
          self.session_start = DateTime.now
        end
      end

      # shortcut method if the organization is not known and there is only one organization
      def init
        unless self.org.blank?
          self.token(self.login)
        else
          unless self.all_orgs.blank?
            set_org(self.all_orgs[0].org_id)
            self.init
          else
            self.all_orgs = self.organizations
            set_org(self.all_orgs[0].org_id)
            self.init
          end
        end
      end

      #generic method for handling the structure of the response. Only creates an error object if there is an error (business error) from Plaid.com. Yields to the block with calling function
      def handle(response)
        if response["response_message"].eql? "Success"
          yield(response)
        else
          PlaidResponse.new(response, response)
        end
      end
    end

  end

end