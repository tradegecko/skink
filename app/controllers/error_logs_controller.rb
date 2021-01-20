class ErrorLogsController < ApplicationController
  before_action :verify_request, except: :create
  before_action :load_collection, only: :index
  before_action :load_resource, only: [:ignore, :retry]

  def index
    @error_logs = ErrorLog.all
    if params[:term]
      @error_logs = @error_logs.where("message LIKE ?", "%#{params[:term]}%")
    end
    if limit
      @error_logs = @error_logs.limit(end_idx)[start_idx..end_idx]
    end
    render json: @error_logs, meta: { total_records: @error_logs.size }, adapter: :json
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

  def offset
    params[:offset] ? params[:offset].to_i : 0
  end

  def start_idx
    offset * limit
  end

  def end_idx
    start_idx + limit
  end

  def permitted_create_params
    params.require(:error_log).permit(:message, :verb, :resource_reference_id)
  end
end
