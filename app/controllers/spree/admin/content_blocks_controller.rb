module Spree
  module Admin
    class ContentBlocksController < ResourceController
      before_action :load_edit_data, except: :index

      create.before :set_product
      update.before :set_product

      def collection
        @product = Product.friendly.find(params[:product_id])
        @product.content_blocks
      end

      private

      def location_after_destroy
        admin_product_content_blocks_url(@product)
      end

      def location_after_save
        admin_product_content_blocks_url(@product)
      end

      def load_edit_data
        @product = Product.friendly.find(params[:product_id])
        @variants = @product.variants.map do |variant|
          [variant.sku_and_options_text, variant.id]
        end
        @variants.insert(0, [Spree.t(:all), @product.master.id])
      end

      def set_product
        @content_block.product = @product
      end
    end
  end
end
