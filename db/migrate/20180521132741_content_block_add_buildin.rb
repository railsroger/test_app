class ContentBlockAddBuildin < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_content_blocks, :built_in_block, :string
  end
end
