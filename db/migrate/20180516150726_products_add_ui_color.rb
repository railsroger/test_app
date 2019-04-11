class ProductsAddUiColor < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_products, :hero_ui_black, :boolean
  end
end
