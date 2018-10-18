class AuthenticationsController < ApplicationController
  def callback
    case params[:provider]
    when 'lazada'
      # This is to simulate the flow after Cresco has been authenticated by Lazada
      # Save the tokens from Lazada
      # Create a Channel in TG
      # Create Webhooks in a background job
      # Redirect to a step in the setup flow
      unless current_account.channels.first
        tradegecko_id = create_channel_in_tradegecko
        current_account.channels.create(tradegecko_id: tradegecko_id, tradegecko_application_id: tradegecko_application_id)
      end
      redirect_to "https://go.tradegecko.com/apps"
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

  def create_channel_in_tradegecko
    response = RestClient::Request.execute({
      method: :post,
      url: "#{ENV['TRADEGECKO_API_URL']}/channels",
      headers: { authorization: "Bearer #{current_account.access_token}" },
      payload: { channel: { name: "ABC Storezzzz", site: "abc.comzzzz" } }
    })
    JSON.parse(response.body)["oauth_channel"]["id"]
  end

  def tradegecko_application_id
    current_account.tradegecko_application_id
  end

  def auth
    request.env["omniauth.auth"]
  end

  def lazada_auth_url
    "https://auth.lazada.com/oauth/authorize?response_type=code&force_auth=true&redirect_uri=#{ENV['NGROK_URL']}/auth/lazada/callback&client_id=#{ENV['LAZADA_APP_KEY']}"
  end
end
