class CountriesAddLink < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_countries, :link, :string
  end
end
