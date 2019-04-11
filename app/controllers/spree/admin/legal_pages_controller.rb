module Spree
  module Admin
    class LegalPagesController < ResourceController
      def find_resource
        Spree::LegalPage.friendly.find(params[:id])
      end
    end
  end
end
