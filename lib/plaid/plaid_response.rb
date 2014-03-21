class PlaidResponse
  include Plaid::Client::Configurations

  require 'plaid/plaid_object'

  attr_reader :http_code, :mfa_message, :accounts, :transactions, :access_token

  @response = nil
  @message = "N/A"
  @mfa_type
  @mfa_message
  @questions = nil
  @mfa_modes = nil
  @is_mfa_initialized = false

  def initialize(response, message=nil, raw=false)
    @http_code = response.code
    zed = PlaidObject.new(response)

    if raw == true
      @response = zed
    end

    unless message.eql?("MFA")
      @accounts = zed.accounts
      @transactions = zed.transactions
      @is_mfa_initialized = false
    else
      manage_mfa_type(zed)
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
    @message.eql?("MFA") ? @mfa_type : "Not a response from an MFA request to a bank"
  end

  def is_mfa?
    @is_mfa_initialized
  end

  def mfa_modes
    @mfa_modes
  end

  def manage_mfa_type(zed)
    @mfa_type = zed.type

    if @mfa_type.eql?("device")
      @mfa_message = zed.mfa["message"]
    elsif @mfa_type.eql?("questions")
      @questions ||= []
      zed.mfa.each do |q|
        @questions << q.question
      end
      @mfa_message = @questions.reverse.pop
    elsif @mfa_type.eql?("list")
      @mfa_modes ||= []
      @mfa_message = "There are several ways to authenticate, or it will default to your email"
      zed.mfa.each do |q|
        @mfa_modes << q
      end
    end

  end

end