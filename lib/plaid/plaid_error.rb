class PlaidError < PlaidObject

  require 'plaid/plaid_object'

  @error = nil
  @message = nil
  @data = nil

  def initialize(response)
    if response.parsed_response
      super(response.parsed_response)
    else
      super(response)
    end
    @data = response
  end

  def error_message
    self.message
  end

  def http_code
    @data.code if @data
  end

  def plaid_code
    self.code
  end

  def resolution
    self.resolve
  end

  def raw_response
    @data if @data
  end
end