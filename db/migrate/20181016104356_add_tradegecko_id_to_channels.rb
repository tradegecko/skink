class AddTradegeckoIdToChannels < ActiveRecord::Migration[5.2]
  def change
    add_column :channels, :tradegecko_id, :integer
  end
end
