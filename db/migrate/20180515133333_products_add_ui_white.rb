class ProductsAddUiWhite < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_products, :hero_ui_white, :boolean, null: false, default: true
  end
end
