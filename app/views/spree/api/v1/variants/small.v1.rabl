cache [I18n.locale, @current_user_roles.include?('admin'), 'small_variant', root_object]

attributes *variant_attributes

node(:display_price) { |p| p.display_price.to_s }
node(:options_text, &:options_text)
node(:track_inventory, &:should_track_inventory?)
node(:in_stock, &:in_stock?)
node(:is_backorderable, &:is_backorderable?)
node(:is_orderable) { |v| v.is_backorderable? || v.in_stock? }
node(:total_on_hand, &:total_on_hand)
node(:is_destroyed, &:destroyed?)

child option_values: :option_values do
  attributes *option_value_attributes
end

node(:images) do |variant|
  [
    mini_url: variant.product.preview_image.url(:admin),
    small_url: variant.product.preview_image.url(:admin),
    product_url: variant.product.preview_image.url(:normal),
    large_url: variant.product.preview_image.url(:normal),
    slider_small_url: variant.product.preview_image.url(:normal),
    slider_large_url: variant.product.preview_image.url(:normal)
  ]
end
