class ChannelsController < ApplicationController
  before_action :verify_request
  before_action :load_resource

  def show
    render json: @channel.settings.to_json
  end

  def settings
    @channel.update(settings: channel_params)
    render json: @channel.settings.to_json
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
end
