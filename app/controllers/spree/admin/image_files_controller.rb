module Spree
  module Admin
    class ImageFilesController < ResourceController
      protect_from_forgery with: :null_session

      def create
        image = Spree::Image.new
        image.attachment = image_params[:file]
        image.viewable_type = 'Spree::News'
        image.save!
        render json: { filelink: image.attachment.url(:slider_small, timestamp: false) }
      end

      private

      def image_params
        params.permit(:file)
      end

      def model_class
        Spree::Image
      end
    end
  end
end
