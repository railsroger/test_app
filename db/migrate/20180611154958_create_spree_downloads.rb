class CreateSpreeDownloads < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_downloads do |t|
      t.integer :kind
      t.string :name
      t.string :description
      t.string :version
      t.date :date
      t.attachment :file

      t.timestamps
    end
  end
end
