class CreateResourceReferences < ActiveRecord::Migration[5.2]
  def change
    create_table :resource_references do |t|
      t.integer :tradegecko_id
      t.string :resource_type
      t.integer :tradegecko_parent_id
      t.string :display_name

      t.timestamps
    end
    add_reference :resource_references, :account, index: true
    add_reference :resource_references, :channel, index: true
  end
end
