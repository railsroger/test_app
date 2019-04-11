module Spree
  module Admin
    class TaxonsRightMenuItemsController < ResourceController
      def destroy
        section = Spree::TaxonsRightMenuItem.find(params[:id])
        section.destroy
        render plain: nil
      end
    end
  end
end
