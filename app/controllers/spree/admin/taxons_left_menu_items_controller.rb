module Spree
  module Admin
    class TaxonsLeftMenuItemsController < ResourceController
      def destroy
        section = Spree::TaxonsLeftMenuItem.find(params[:id])
        section.destroy
        render plain: nil
      end
    end
  end
end
