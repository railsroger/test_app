module Spree
  module Admin
    class SubscribersController < ResourceController
      def collection
        return @collection if @collection.present?
        @collection = super
        @collection = @collection.page(params[:page])
                                 .per(params[:per_page] || Spree::Config[:admin_products_per_page])
        @collection
      end

      def download
        @messages = Spree::Subscriber.all

        respond_to do |format|
          format.xls do
            contents = StringIO.new
            DataShift::ExcelExporter.new.export(contents, @messages)
            send_data contents.string.force_encoding('binary'), type: 'application/xls'
          end
        end
      end
    end
  end
end
