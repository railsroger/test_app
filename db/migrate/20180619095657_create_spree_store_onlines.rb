class CreateSpreeStoreOnlines < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_online_stores do |t|
      t.integer :position
      t.string :name
      t.string :url
      t.string :favicon_url

      t.timestamps
    end
  end
end
