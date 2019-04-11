class AddDownloadsSettings < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_stores, :downloads_blank_text, :string
    add_attachment :spree_stores, :downloads_blank_icon, :string
  end
end
