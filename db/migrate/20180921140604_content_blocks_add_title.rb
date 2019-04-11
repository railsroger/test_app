class ContentBlocksAddTitle < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_content_blocks, :title, :string
    add_column :spree_content_blocks, :text, :text
  end
end
