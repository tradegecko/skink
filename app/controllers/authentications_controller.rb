class AuthenticationsController < ApplicationController
  def callback
    # This is to simulate the flow after Cresco has been authenticated by Lazada
    # Save the tokens from Lazada
    # Create Channel in TG
    # Create webhooks in a background job
    # redirect to install flow settings step
    redirect_to "http://go.lvh.me:3000/integrations/shopify-install/location-setting/174"
  end
end
