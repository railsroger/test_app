module Spree
  module Admin
    class CompanyBlockSectionsController < ResourceController
      def destroy
        section = Spree::CompanyBlockSection.find(params[:id])
        section.destroy
        render plain: nil
      end
    end
  end
end
