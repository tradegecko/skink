class SessionsController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]

  def destroy
    clear_session
    render inline: "You have been logged out"
  end
end
