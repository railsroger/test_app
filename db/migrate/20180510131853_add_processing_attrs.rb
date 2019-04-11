class AddProcessingAttrs < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_company_blocks, :video_processing, :boolean
    add_column :spree_hero_slides, :video_processing, :boolean
  end
end
