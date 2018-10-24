class AuthenticationsController < ApplicationController
  def callback
    case params[:provider]
    when 'lazada'
      # This is to simulate the flow after this app has been authenticated by Lazada
      # Save the tokens from Lazada
      # Create a Channel in TradeGecko
      # Create Webhooks in a background job (optional)
      # Using the TradeGecko channel_id, redirect to a step in the setup flow
      unless current_account.channels.first
        tradegecko_id = create_channel_in_tradegecko
        current_account.channels.create(tradegecko_id: tradegecko_id, tradegecko_application_id: tradegecko_application_id)
      end

      redirect_to "https://go.tradegecko.com/apps"
    when 'tradegecko'
      # Clicking install from TradeGecko would redirect the user to this URL:
      # https://tradegecko-skink.herokuapp.com/auth/tradegecko

      # This should start the Oauth dance with TradeGecko

      # Once authenticated with TradeGecko, an account needs to be created
      # in order to store the TradeGecko's account ID and the access and refresh
      # tokens

      account = Account.find_or_create_from_omniauth(auth)
      token = OAuth2::AccessToken.new(OAuthSession.oauth_client,
        auth["credentials"]["token"],
        auth["credentials"].slice("refresh_token", "expires_at")
      )
      account.update_from_access_token(token)
      session[:account_id] = account.id
      session[:user_id] = auth.uid

      # Once the Account record is created we should now start the authentication
      # process with Lazada

      redirect_to lazada_auth_url
    end
  end

private

  def create_channel_in_tradegecko
    # Name and site is hardcoded for now but those details need to be
    # pulled from the seller endpoint
    # https://open.lazada.com/doc/api.htm?spm=a2o9m.11193531.0.0.1e106bbeb3JTOL#/api?cid=2&path=/seller/get

    response = RestClient::Request.execute({
      method: :post,
      url: "#{ENV['TRADEGECKO_API_URL']}/channels",
      headers: { authorization: "Bearer #{current_account.access_token}" },
      payload: { channel: { name: "LAZOP Test 3", site: "https://www.lazada.sg/shop/LAZOP-Test-3" } }
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
    "https://auth.lazada.com/oauth/authorize?response_type=code&force_auth=true&redirect_uri=#{ENV['INTEGRATOR_URL']}/auth/lazada/callback&client_id=#{ENV['LAZADA_APP_KEY']}"
  end
end
