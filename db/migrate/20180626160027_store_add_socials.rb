class StoreAddSocials < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_stores, :fb_link, :string
    add_column :spree_stores, :tw_link, :string
    add_column :spree_stores, :ig_link, :string
  end
end
