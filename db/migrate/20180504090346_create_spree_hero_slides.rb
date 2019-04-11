class CreateSpreeHeroSlides < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_hero_slides do |t|
      t.string :title
      t.string :link
      t.integer :position
      t.integer :title_vertical_align
      t.integer :title_horizontal_align
      t.attachment :image
      t.attachment :video

      t.timestamps
    end
  end
end
