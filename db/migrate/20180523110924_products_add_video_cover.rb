class ProductsAddVideoCover < ActiveRecord::Migration[5.1]
  def change
    add_attachment :spree_products, :video_cover
  end
end
