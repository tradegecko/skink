class AuthenticationsController < ApplicationController
  def callback
    case params[:provider]
    when 'lazada'
      # This is to simulate the flow after Cresco has been authenticated by Lazada
      # Save the tokens from Lazada
      # Create Channel in TG
      # Create webhooks in a background job
      # redirect to install flow settings step
      redirect_to "http://go.lvh.me:3000/integrations/shopify-install/location-setting/174"
    when 'tradegecko'
      account = Account.find_or_create_from_omniauth(auth)
      token = OAuth2::AccessToken.new(OAuthSession.oauth_client,
        auth["credentials"]["token"],
        auth["credentials"].slice("refresh_token", "expires_at")
      )
      account.update_from_access_token(token)
      session[:account_id] = account.id
      session[:user_id] = auth.uid
      redirect_to lazada_auth_url
    end
  end

private

  def auth
    request.env["omniauth.auth"]
  end

  def lazada_auth_url
    "https://auth.lazada.com/oauth/authorize?response_type=code&force_auth=true&redirect_uri=#{ENV['NGROK_URL']}/auth/lazada/callback&client_id=106561"
  end
end
