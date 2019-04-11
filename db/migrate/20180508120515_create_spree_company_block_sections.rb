class CreateSpreeCompanyBlockSections < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_company_block_sections do |t|
      t.references :company_block
      t.integer :position
      t.string :link
      t.string :name

      t.timestamps
    end
  end
end
