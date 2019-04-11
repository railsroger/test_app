module Spree
  module Admin
    class NewsController < ResourceController
      def collection
        return @collection if @collection.present?
        @collection = super
        @collection = @collection.order(published_on: :desc)
                                 .page(params[:page])
                                 .per(params[:per_page] || Spree::Config[:admin_products_per_page])
        @collection
      end

      def find_resource
        Spree::News.friendly.find(params[:id])
      end
    end
  end
end
