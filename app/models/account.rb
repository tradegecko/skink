class Account < ApplicationRecord
  belongs_to :tradegecko_application
  has_many :channels
  has_many :resource_references

  def self.find_or_create_from_omniauth(auth)
    tradegecko_application = TradegeckoApplication.find_by(provider: auth['provider'])
    self.where(
      tradegecko_id: auth.info.account_id,
      tradegecko_application_id: tradegecko_application.id
    ).first_or_create
  end

  def update_from_access_token(access_token)
    self.access_token  = access_token.token
    self.refresh_token = access_token.refresh_token
    self.expires_at    = access_token.expires_at
    self.save
  end
end
