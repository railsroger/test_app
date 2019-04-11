class PropertyAddIsInteger < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_properties, :is_number, :boolean, null: false, default: false
  end
end
