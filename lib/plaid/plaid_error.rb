class PlaidError < PlaidObject

  require 'plaid/plaid_object'

  @error = nil
  @message = nil
  @response = nil

  def initialize(response, message)
    if response.parsed_response
      super(response.parsed_response)
    else
      super(response)
    end
    @response = response
    @message = message
  end

  def error_message
    self.message
  end

  def http_code
    @response.code if @response
  end

  def plaid_code
    response.code
  end

  def resolution
    self.resolve
  end

  def raw_response
    @response if @response
  end
end