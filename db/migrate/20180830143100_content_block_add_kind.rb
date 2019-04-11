class ContentBlockAddKind < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_content_blocks, :kind, :integer, null: false, default: 0
  end
end
