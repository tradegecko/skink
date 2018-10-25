class ChannelsController < ApplicationController
  before_action :verify_request, only: [:show, :settings]
  before_action :load_resource

  def show
    render json: @channel.settings.to_json
  end

  def settings
    @channel.update(settings: channel_params)
    render json: @channel.settings.to_json
  end

  def edit; end

  def update
    @channel.update(permitted_update_params)

    # Update the Channel in Tradegecko, so Tradegecko can show error_count and connection_status in the app.
    RestClient::Request.execute({
      method: :put,
      url: "#{ENV['TRADEGECKO_API_URL']}/channels/#{@channel.tradegecko_id}",
      headers: { authorization: "Bearer #{current_account.access_token}" },
      payload: { id: @channel.tradegecko_id, channel: permitted_update_params.to_unsafe_hash }
    })

    flash[:notice] = 'Channel updated!'
    redirect_to edit_channel_path
  end

private

  def verify_request
    TradegeckoVerifier.new(request).run
  end

  def load_resource
    @channel = Channel.find_by(tradegecko_id: params[:id])
  end

  def channel_params
    params.permit!
  end

  def permitted_update_params
    params.require(:channel).permit(:error_count, :connection_status)
  end
end
