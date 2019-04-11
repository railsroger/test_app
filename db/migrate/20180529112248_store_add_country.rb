class StoreAddCountry < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_stores, :country_id, :integer
  end
end
