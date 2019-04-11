class CreateSpreeNews < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_news do |t|
      t.references :category, index: true
      t.references :sponsorship, index: true
      t.string :title
      t.date :published_on
      t.attachment :list_image
      t.boolean :is_published
      t.attachment :main_image
      t.text :text_raw
      t.text :text
      t.string :slug

      t.timestamps
    end
  end
end
