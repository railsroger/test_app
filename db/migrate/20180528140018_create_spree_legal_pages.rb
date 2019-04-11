class CreateSpreeLegalPages < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_legal_pages do |t|
      t.integer :position
      t.string :title
      t.string :slug
      t.text :html

      t.timestamps
    end
  end
end
