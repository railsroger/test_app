class CreateSpreeNewsCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_news_categories do |t|
      t.integer :position
      t.string :name
      t.string :color

      t.timestamps
    end
  end
end
