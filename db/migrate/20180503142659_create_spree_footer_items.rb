class CreateSpreeFooterItems < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_footer_items do |t|
      t.string :name
      t.string :url
      t.integer :position

      t.timestamps
    end
  end
end
