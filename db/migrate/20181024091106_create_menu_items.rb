class CreateMenuItems < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_left_menu_items do |t|
      t.references :store
      t.integer :position
      t.string :name
      t.string :url
      t.boolean :is_active, null: false, default: true

      t.timestamps
    end
    create_table :spree_right_menu_items do |t|
      t.references :store
      t.integer :position
      t.string :name
      t.string :url
      t.boolean :is_active, null: false, default: true

      t.timestamps
    end
  end
end
