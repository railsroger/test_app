module Spree
  module Admin
    class MessagesController < ResourceController
      def collection
        return @collection if @collection.present?
        params[:q] ||= {}

        params[:q][:s] ||= 'created_at desc'
        @collection = super

        @search = @collection.ransack(params[:q])
        @collection = @search.result
                             .page(params[:page])
                             .per(params[:per_page] || Spree::Config[:admin_products_per_page])
        @collection
      end

      def download
        @messages = Spree::Message.all

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
