class AddProviderColumnToTradegeckoApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :tradegecko_applications, :provider, :string
  end
end
