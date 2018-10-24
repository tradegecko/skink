class SessionsController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]

  def setup
    tradegecko_application = TradegeckoApplication.find_by(provider: params[:provider])
    request.env['omniauth.strategy'].options[:client_id] = tradegecko_application.client_id
    request.env['omniauth.strategy'].options[:client_secret] = tradegecko_application.client_secret
    render plain: "Omniauth setup phase.", status: 404
  end

  def destroy
    clear_session
    render inline: "You have been logged out"
  end
end
