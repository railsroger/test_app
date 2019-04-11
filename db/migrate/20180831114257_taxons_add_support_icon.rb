class TaxonsAddSupportIcon < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_taxons, :support_icon, :string
  end
end
