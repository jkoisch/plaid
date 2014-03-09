class PlaidError < PlaidObject

  require 'plaid/plaid_object'

  @error = nil
  @status = nil
  @message = nil
  @data = nil
  @error_code = nil
  @error_message = nil

  def initialize(response)
    super(JSON.parse(response))

    @data = self.response_data
    @status = self.response_status
  end

  def error_message
    @data["error_message"] if @data
  end

  def status
    @status if @status
  end

  def error_code
    @data["error_code"] if @data
  end

  def raw_response
    @data if @data
  end
end