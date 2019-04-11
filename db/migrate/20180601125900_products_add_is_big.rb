class ProductsAddIsBig < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_products, :big_preview, :boolean, null: false, default: false
  end
end
