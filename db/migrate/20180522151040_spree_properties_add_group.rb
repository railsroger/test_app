class SpreePropertiesAddGroup < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_properties, :group, :string
  end
end
