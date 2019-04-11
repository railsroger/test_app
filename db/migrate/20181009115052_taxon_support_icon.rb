class TaxonSupportIcon < ActiveRecord::Migration[5.1]
  def change
    remove_column :spree_taxons, :support_icon, :string
    add_attachment :spree_taxons, :support_icon
  end
end
