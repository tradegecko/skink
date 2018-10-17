class Account < ApplicationRecord
  has_many :channels
  belongs_to :tradegecko_application

  def self.find_or_create_from_omniauth(auth)
    self.where(tradegecko_id: auth.info.account_id).first_or_create
  end

  def update_from_access_token(access_token)
    self.access_token  = access_token.token
    self.refresh_token = access_token.refresh_token
    self.expires_at    = access_token.expires_at
    self.save
  end
end
