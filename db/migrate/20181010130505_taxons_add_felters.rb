class TaxonsAddFelters < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_taxons, :filter1_id, :integer
    add_column :spree_taxons, :filter2_id, :integer
    add_column :spree_taxons, :filter3_id, :integer
    add_column :spree_taxons, :filter4_id, :integer
  end
end
