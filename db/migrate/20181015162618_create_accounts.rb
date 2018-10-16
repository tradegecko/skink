class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.integer :tradegecko_id
      t.string :access_token
      t.string :refresh_token
      t.integer :expires_at

      t.timestamps
    end
  end
end
