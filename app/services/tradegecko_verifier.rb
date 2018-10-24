class TradegeckoVerifier
  class UnverifiedRequest < StandardError; end
  delegate :params, :headers, to: :request
  attr_reader :request

  def initialize(request)
    @request = request
  end

  def run
    unless verification_passed?
      raise UnverifiedRequest.new("The request is not from TradeGecko")
    end
  end

private

  def calculated_hmac
    digest  = OpenSSL::Digest.new('sha256')
    Base64.encode64(OpenSSL::HMAC.digest(digest, ENV['OAUTH_SECRET'], request_data)).strip
  end

  def request_data
    data = request.body.read.to_s
    request.body.rewind
    data == "{}" ? params[:id] : data
  end

  def verification_passed?
    calculated_hmac == headers['X-Gecko-Signature']
  end
end
