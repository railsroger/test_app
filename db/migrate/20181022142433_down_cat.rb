class DownCat < ActiveRecord::Migration[5.1]
  def change
    remove_column :spree_downloads, :kind
    add_column :spree_downloads, :category_id, :integer
  end
end
