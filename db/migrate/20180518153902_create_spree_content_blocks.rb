class CreateSpreeContentBlocks < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_content_blocks do |t|
      t.references :product, index: true
      t.integer :position, default: 0
      t.boolean :hero_ui_black
      t.boolean :is_active, null: false, default: true
      t.string :color
      t.string :bg_color
      t.string :name
      t.attachment :bg_image
      t.text :html

      t.timestamps
    end
  end
end
