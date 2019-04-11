module Spree
  module Admin
    class ContactContentsController < ResourceController
      def index
        redirect_to edit_object_url(Spree::ContactContent.find(1))
      end

      protected

      def location_after_save
        edit_object_url(@contact_content)
      end
    end
  end
end
