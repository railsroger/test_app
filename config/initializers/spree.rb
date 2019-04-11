require 'spree/core/product_filters'

Spree.config do |config|
  config.track_inventory_levels = false
  config.products_per_page = 999
  config.default_country_id = 44
  config.address_requires_state = false
  config.allow_guest_checkout = false
end

Spree.user_class = 'Spree::User'

Spree::Image.attachment_definitions[:attachment][:styles] = {
  mini: '48x48>',
  small: '100x100>',
  product: '450x450>',
  large: '1920x1080>'
}

# Размеры для сетки
# большая 1920 * 1024
# половина 960 * 1024
# четверть 960 * 512
# восьмая  480 * 512

begin
  Rails.application.routes.default_url_options = { host: Spree::Store.current.url }
  Rails.application.config.action_mailer.default_url_options = { host: Spree::Store.current.url }
  Rails.application.config.action_mailer.asset_host = Spree::Store.current.url
rescue Exception
  puts 'never mind'
end
