class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  rescue_from OAuth2::Error do |exception|
    case exception.response.status
    when 402
      flash[:notice] = exception.message
      redirect_to "/auth/failure"
    else
      redirect_to "/auth/tradegecko"
    end
  end

  private

  def authenticate_user!
    redirect_to "/auth/tradegecko" unless user_signed_in?
  end

  def user_signed_in?
    !!session[:account_id]
  end

  def clear_session
    session.delete(:account_id)
    session.delete(:user_id)
  end

  helper_method :current_account
  def current_account
    return unless user_signed_in?
    @current_account ||= Account.find(session[:account_id])
  end

  def gecko
    @gecko ||= OAuthSession.new(current_account).gecko
  end

  def user_for_papertrail
    session[:user_id]
  end
end
