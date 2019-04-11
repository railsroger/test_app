class ContentBlocksAddHtml2 < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_content_blocks, :html2, :text
  end
end
