module Spree
  class RegisterProductController < Spree::BaseController
    include Spree::Core::ControllerHelpers::Order
    include Spree::Core::ControllerHelpers::Auth
    include Spree::Core::ControllerHelpers::Store
    include Spree::Core::ControllerHelpers::Common
    helper Spree::BaseHelper

    before_action :check_availability

    def create
      message = Spree::Message.create(message_params.merge(reason: 'Register product'))
      PostbotMailer.message_to_manager(message.id).deliver!
      head :ok
    end

    private

    def message_params
      params.permit(:reason, :email, :address, :name, :phone, :message,
                    :country, :region, :city, :post_code, :product_type,
                    :date_of_purchase, :retailer, :model_number, :serial_number,
                    :subscribe)
    end

    def check_availability
      redirect_to root_path and return if current_store.country.iso == 'CN'
    end
  end
end
