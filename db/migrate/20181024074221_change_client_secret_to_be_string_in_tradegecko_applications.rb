class ChangeClientSecretToBeStringInTradegeckoApplications < ActiveRecord::Migration[5.2]
  def change
    change_column :tradegecko_applications, :client_secret, :string
  end
end
