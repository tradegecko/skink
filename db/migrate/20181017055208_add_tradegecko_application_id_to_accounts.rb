class AddTradegeckoApplicationIdToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_reference :accounts, :tradegecko_application, index: true
  end
end
