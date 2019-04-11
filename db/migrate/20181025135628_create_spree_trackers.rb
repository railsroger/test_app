class CreateSpreeTrackers < ActiveRecord::Migration[5.1]
  def up
    drop_table :spree_trackers

    create_table :spree_trackers do |t|
      t.string :name
      t.boolean :active, null: false, default: true
      t.text :code

      t.timestamps
    end
  end
end
