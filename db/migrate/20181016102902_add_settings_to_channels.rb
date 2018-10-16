class AddSettingsToChannels < ActiveRecord::Migration[5.2]
  def change
    add_column :channels, :settings, :jsonb, default: {}
  end
end
