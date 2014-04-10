module Plaid
  module Scaffold
    class Base

      require 'plaid/scaffold/institution'
      require 'plaid/scaffold/category'
      require 'plaid/client/configuration'
      require 'plaid/plaid_object'
      require 'plaid/plaid_error'
      require 'plaid/plaid_response'
      require 'httparty'
      require 'singleton'
      include Plaid::Scaffold::Institutions
      include Plaid::Scaffold::Categories
      include Plaid::Client::Configurations
      include HTTParty
      include Singleton

      base_uri endpoint
      format :json
      ssl_ca_file certpath
      ssl_version :SSLv3
      debug_output $stdout

      @@institutions ||= []

      def self.institutions=(i)
        @@institutions = i
      end

      def self.institutions
        if @@institutions.empty?
          self.index_institutions rescue "There is something wrong with Plaid!"
        end

        @@institutions
      end

      def self.category(cat_id)
        self.get_category(cat_id) rescue "There is something wrong with Plaid!"
      end

    end
  end
end