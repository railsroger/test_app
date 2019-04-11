class ProductAddAttrs < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_products, :is_new, :boolean, null: false, default: false
    # Product preview
    add_attachment :spree_products, :preview_image
    add_column :spree_products, :preview_description, :string
    add_column :spree_products, :preview_features, :text

    # Hero Block
    add_column :spree_products, :hero_alignment_right, :boolean, null: false, default: false
    add_column :spree_products, :hero_super_title, :string
    add_column :spree_products, :hero_title, :string
    add_attachment :spree_products, :hero_image
    add_attachment :spree_products, :hero_bg_image
    add_column :spree_products, :hero_bg_color, :string

    add_attachment :spree_products, :video

    add_column :spree_products, :model_number, :string
    add_column :spree_products, :model_year, :string

    add_column :spree_products, :disclaimer, :text
  end
end
