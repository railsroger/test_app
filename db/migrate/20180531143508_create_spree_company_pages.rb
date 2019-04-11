class CreateSpreeCompanyPages < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_company_pages do |t|
      t.integer :position
      t.string :title
      t.text :header
      t.text :text
      t.attachment :image
      t.integer :page_type, null: false, default: 0

      t.timestamps
    end
  end
end
