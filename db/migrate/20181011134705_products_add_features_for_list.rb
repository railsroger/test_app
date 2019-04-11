class ProductsAddFeaturesForList < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_products, :list_feature_left, :string
    add_column :spree_products, :list_feature_right, :string
  end
end
