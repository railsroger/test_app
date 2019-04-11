module Spree
  module Admin
    class LeftMenuItemsController < ResourceController
      def index
        redirect_to admin_menu_items_url and return
      end
    end
  end
end
