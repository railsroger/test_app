class CreateSpreeFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_files do |t|
      t.attachment :attachment
      t.string :name

      t.timestamps
    end
  end
end
