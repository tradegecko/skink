class AdminController < ApplicationController
  def index
  end

  def clear_all
    Account.delete_all
    Channel.delete_all
    ErrorLog.delete_all
    ResourceReference.delete_all
  end
end
