class TaxonsAddBg < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_taxons, :bg_color, :string
    add_attachment :spree_taxons, :bg_image
    add_attachment :spree_taxons, :image
    add_column :spree_taxons, :ui_black, :boolean, null: false, default: false
  end
end
