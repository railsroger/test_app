class CreateSpreeCompanyBlocks < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_company_blocks do |t|
      t.boolean :is_active
      t.string :main_statement
      t.string :video_statement
      t.attachment :video_cover
      t.attachment :video

      t.timestamps
    end
  end
end
