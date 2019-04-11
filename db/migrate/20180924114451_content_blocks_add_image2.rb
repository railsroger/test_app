class ContentBlocksAddImage2 < ActiveRecord::Migration[5.1]
  def change
    add_attachment :spree_content_blocks, :image2
    add_attachment :spree_content_blocks, :image3
    add_attachment :spree_content_blocks, :image4
  end
end
