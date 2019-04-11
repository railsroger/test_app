class ContentBlocksAddTitles < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_content_blocks, :title2, :string
    add_column :spree_content_blocks, :title3, :string
    add_column :spree_content_blocks, :title4, :string
    add_column :spree_content_blocks, :text2, :text
    add_column :spree_content_blocks, :text3, :text
    add_column :spree_content_blocks, :text4, :text
  end
end
