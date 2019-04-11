class ProductsAddIcons < ActiveRecord::Migration[5.1]
  def change
    add_attachment :spree_products, :icon_white1
    add_attachment :spree_products, :icon_dark1
    add_attachment :spree_products, :icon_white2
    add_attachment :spree_products, :icon_dark2
    add_attachment :spree_products, :icon_white3
    add_attachment :spree_products, :icon_dark3
    add_attachment :spree_products, :icon_white4
    add_attachment :spree_products, :icon_dark4
    add_attachment :spree_products, :icon_white5
    add_attachment :spree_products, :icon_dark5
  end
end
