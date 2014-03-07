module Client
  module Bodies
    # Used before the organization is obtained and chosen by the user
    def body
      {
          :userName => self.username,
          :password => self.password,
          :client_id => self.client_id,
          :secret => self.secret
      }
    end

    def body_institution
      ret = body
      ret[:type] = self.institution
    end
  end
end