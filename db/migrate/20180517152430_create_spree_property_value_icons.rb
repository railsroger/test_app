class CreateSpreePropertyValueIcons < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_property_value_icons do |t|
      t.references :property, index: true
      t.string :value
      t.attachment :icon_white
      t.attachment :icon_dark
      t.integer :position, default: 0

      t.timestamps
    end
  end
end
