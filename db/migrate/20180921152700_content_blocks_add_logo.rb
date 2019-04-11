class ContentBlocksAddLogo < ActiveRecord::Migration[5.1]
  def change
    add_attachment :spree_content_blocks, :logo
  end
end
