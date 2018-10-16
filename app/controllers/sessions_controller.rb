class SessionsController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]

  def create
    account = Account.find_or_create_from_omniauth(auth)
    token = OAuth2::AccessToken.new(OAuthSession.oauth_client,
      auth["credentials"]["token"],
      auth["credentials"].slice("refresh_token", "expires_at")
    )
    account.update_from_access_token(token)
    session[:account_id] = account.id
    session[:user_id] = auth.uid
    redirect_to root_url
  end

  def destroy
    clear_session
    render inline: "You have been logged out"
  end

private

  def auth
    request.env["omniauth.auth"]
  end
end
