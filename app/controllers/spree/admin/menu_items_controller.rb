module Spree
  module Admin
    class MenuItemsController < ResourceController
      def index
        @left_menu_items = Spree::LeftMenuItem.all
        @right_menu_items = Spree::RightMenuItem.all
      end

      def collection
        []
      end
    end
  end
end

class Spree::MenuItem; end
