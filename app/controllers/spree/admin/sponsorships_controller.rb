module Spree
  module Admin
    class SponsorshipsController < ResourceController
      def find_resource
        Spree::Sponsorship.friendly.find(params[:id])
      end
    end
  end
end
