class PlaidResponse

  require 'plaid/plaid_object'

  @response = nil
  @message = "N/A"
  @access_token
  @transactions
  @accounts
  @mfa_type
  @mfa_message
  @is_mfa_initialized = false

  def initialize(response, message=nil, raw=false)

    zed = PlaidObject.new(response)

    if raw == true
      @response = zed
    end

    unless message.eql?("MFA")
      @accounts = zed.accounts
      @transactions = zed.transactions
      @is_mfa_initialized = false
    else
      @mfa_message = zed.mfa["message"]
      @mfa_type = zed.type
      @is_mfa_initialized = true
    end

    @access_token = zed.access_token

    @message = message if message

    zed = nil
  end

  def raw_response
    @response
  end

  def message
    @message.eql?("MFA") ? @message + ": " + @mfa_message : @message
  end

  def mfa_type
    @message.eql?("MFA") ? @mfa_type : "Not an MFA bank"
  end

  def accounts
    @accounts
  end

  def is_mfa?
    @is_mfa_initialized
  end

  def transactions
    @transactions
  end

  def access_token
    @access_token
  end

  def http_code
    @response.code
  end

end