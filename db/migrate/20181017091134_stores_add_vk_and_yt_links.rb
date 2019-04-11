class StoresAddVkAndYtLinks < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_stores, :vk_link, :string
    add_column :spree_stores, :yt_link, :string
  end
end
