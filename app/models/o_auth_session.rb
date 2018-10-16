class OAuthSession
  attr_reader :account

  def initialize(account)
    @account = account
  end

  def access_token
    @access_token ||= fetch_access_token
  end

  def gecko
    @gecko ||= begin
      client = Gecko::Client.new(oauth_client.id, oauth_client.secret)
      client.access_token = access_token
      client
    end
  end

private

  def fetch_access_token
    token = OAuth2::AccessToken.new(oauth_client,  account.access_token, {
      refresh_token: account.refresh_token,
      expires_at:    account.expires_at
    })

    AccessTokenWrapper::Base.new(token) do |new_token, exception|
      if exception
        Rails.logger.warn "Refreshing OAuth Token due to exception: #{exception.response.status}: #{exception.response.body}"
      else
        Rails.logger.warn "Refreshing OAuth Token due to expiry"
      end
      account.update_from_access_token(new_token)
    end
  end

  def oauth_client
    self.class.oauth_client
  end

  def self.oauth_client
    @oauth_client ||= OAuth2::Client.new(ENV["OAUTH_ID"], ENV["OAUTH_SECRET"], site: site_path)
  end

  def self.site_path
    ENV["TRADEGECKO_API_URL"] || "https://api.tradegecko.com"
  end
end
