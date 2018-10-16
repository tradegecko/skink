class CreateTradegeckoApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :tradegecko_applications do |t|
      t.integer :oauth_application_id
      t.string :client_id
      t.integer :client_secret
    end
  end
end
