Rails.application.config.middleware.use OmniAuth::Builder do
  provider :tradegecko, ENV['OAUTH_ID'], ENV['OAUTH_SECRET']
  provider :developer, uid_field: :id, fields: [:account_id, :credentials] if Rails.env.test?
end

if ENV["TRADEGECKO_API_URL"]
  OmniAuth::Strategies::TradeGecko.option("client_options", {
    site: ENV["TRADEGECKO_API_URL"],
    authorize_path:"/oauth/authorize"
  })
end
