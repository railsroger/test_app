class TaxonsAddFavoritesAttrs < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_taxons, :favorites_title, :string

    add_column :spree_taxons, :left_banner_title, :string
    add_column :spree_taxons, :left_banner_link, :string
    add_attachment :spree_taxons, :left_banner_image

    add_column :spree_taxons, :right_banner_title, :string
    add_column :spree_taxons, :right_banner_link, :string
    add_attachment :spree_taxons, :right_banner_image
  end
end
