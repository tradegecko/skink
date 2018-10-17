class CreateErrorLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :error_logs do |t|
      t.string :message
      t.string :verb

      t.timestamps
    end
    add_reference :error_logs, :channel, index: true
    add_reference :error_logs, :resource_reference, index: true
  end
end
