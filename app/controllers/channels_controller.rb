class ChannelsController < ApplicationController
  def settings
    TradegeckoVerifier.new(request).run
    channel = Channel.find_by(tradegecko_id: channel_params[:id])
    if channel_params[:settings]
      channel.update(settings: channel_params[:settings])
    end
    render json: channel.settings.to_json
  end

private

  def channel_params
    params.require(:channel).permit!
  end
end
