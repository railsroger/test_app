class CountriesAddDisplay < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_countries, :position, :integer
    add_column :spree_countries, :display, :boolean, null: false, default: false
    add_attachment :spree_countries, :flag
  end
end
