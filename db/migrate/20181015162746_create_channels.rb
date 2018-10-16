class CreateChannels < ActiveRecord::Migration[5.2]
  def change
    create_table :channels do |t|
      t.integer :error_count
      t.string :connection_status

      t.timestamps
    end
    add_reference :channels, :account, index: true
    add_reference :channels, :tradegecko_application, index: true
  end
end
