class CreateSpreeTaxonsLeftMenuItems < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_taxons_left_menu_items do |t|
      t.references :taxon
      t.string :name
      t.string :link
      t.integer :position

      t.timestamps
    end
  end
end
