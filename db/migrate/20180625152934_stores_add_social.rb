class StoresAddSocial < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_stores, :og_title, :string
    add_column :spree_stores, :og_description, :text
    add_attachment :spree_stores, :og_image
  end
end
