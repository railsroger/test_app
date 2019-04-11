module Spree
  module Admin
    class DownloadsController < ResourceController
      def collection
        return @collection if @collection.present?
        @collection = super
        @collection = @collection.order(date: :desc)
                                 .page(params[:page])
                                 .per(params[:per_page] || Spree::Config[:admin_products_per_page])
        @collection
      end
    end
  end
end
