class DownloadsAddProductId < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_downloads, :product_id, :integer
  end
end
