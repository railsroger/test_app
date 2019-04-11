class CreateSpreeCareers < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_careers do |t|
      t.attachment :image
      t.attachment :video
      t.boolean :video_processing
      t.string :link
      t.integer :position
      t.string :title
      t.integer :title_horizontal_align
      t.integer :title_vertical_align

      t.timestamps
    end
  end
end
