class CreateSpreeSponsorships < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_sponsorships do |t|
      t.integer :position
      t.string :name
      t.attachment :preview_image
      t.attachment :main_image
      t.attachment :pattern_image
      t.string :slogan
      t.string :slug
      t.text :text

      t.timestamps
    end
  end
end
