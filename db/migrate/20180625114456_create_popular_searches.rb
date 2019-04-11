class CreatePopularSearches < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_popular_searches do |t|
      t.integer :position
      t.string :text

      t.timestamps
    end
  end
end
