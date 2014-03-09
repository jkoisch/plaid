class PlaidResponse

  require 'plaid/plaid_error'

  @response = nil
  @message = "N/A"

  def initialize(response, error=nil, message=nil)
    @response = response

    @message = message if message

    @error = PlaidError.new(response.body.gsub('\"','"').gsub('\n','')) if error
  end

  def error
    @error unless @error.nil?
  end

  def raw_response
    @response
  end

  def message
    @message
  end
end