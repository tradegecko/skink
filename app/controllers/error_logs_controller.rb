class ErrorLogsController < ApplicationController
  # before_action :verify_request, except: :create
  before_action :load_collection, only: :index
  before_action :load_resource, only: [:ignore, :retry]

  def index
    @error_logs = ErrorLog.all
    if limit
      @error_logs = ErrorLog.all.limit(limit).offset(offset)
    end
    if params[:term]
      @error_logs = ErrorLog.where("message LIKE ?", "%#{params[:term]}%").limit(limit).offset(offset)
    end
    render json: @error_logs, root: :error_logs, meta: { total_records: ErrorLog.count }, adapter: :json
  end

  # Used to create error logs for testing purposes
  def create
    @error_log = ErrorLog.create(permitted_create_params.merge({ channel_id: params[:id] }))
    render json: @error_log
  end

  def ignore
    @error_log.delete
  end

  def retry
    # Add retry logic here
    @error_log.delete
  end

private

  def verify_request
    TradegeckoVerifier.new(request).run
  end

  def load_collection
    @error_logs = ErrorLog.where(channel_id: params[:id])
  end

  def load_resource
    @error_log = ErrorLog.find(params[:error_id])
  end

  def limit
    params[:limit] ? params[:limit].to_i : nil
  end

  def page
    params[:page] ? params[:page].to_i : 1
  end

  def offset
    (page - 1) * limit
  end

  def permitted_create_params
    params.require(:error_log).permit(:message, :verb, :resource_reference_id)
  end
end
