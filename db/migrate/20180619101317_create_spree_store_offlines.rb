class CreateSpreeStoreOfflines < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_offline_stores do |t|
      t.integer :position
      t.string :name
      t.string :pin_color
      t.string :address
      t.string :coordinates

      t.timestamps
    end
  end
end
