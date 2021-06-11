class TradegeckoVerifier
  class UnverifiedRequest < StandardError; end
  delegate :params, :headers, to: :request
  attr_reader :request, :verifier_token

  def initialize(request, verifier_token)
    @request = request
    @verifier_token = verifier_token
  end

  def run
    unless verification_passed?
      raise UnverifiedRequest.new("The request is not from TradeGecko")
    end
  end

private

  def calculated_hmac
    digest = OpenSSL::Digest.new('sha256')
    Base64.encode64(OpenSSL::HMAC.digest(digest, verifier_token, request_data)).strip
  end

  def request_data
    data = request.body.read.to_s
    request.body.rewind
    data.presence || params[:id]
  end

  def verification_passed?
    calculated_hmac == headers['X-Gecko-Signature']
  end
end
