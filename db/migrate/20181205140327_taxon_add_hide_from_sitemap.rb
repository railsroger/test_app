class TaxonAddHideFromSitemap < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_taxons, :hide_from_sitemap, :boolean, null: false, default: false
  end
end
