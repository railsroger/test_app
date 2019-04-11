module Spree
  module Admin
    class FilesController < ResourceController
      def collection
        return @collection if @collection.present?
        @collection = super
        @collection = @collection.page(params[:page])
                        .per(params[:per_page] || Spree::Config[:admin_products_per_page])
        @collection
      end
    end
  end
end
