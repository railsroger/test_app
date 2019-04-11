module Spree
  class ContactController < Spree::BaseController
    include Spree::Core::ControllerHelpers::Order
    include Spree::Core::ControllerHelpers::Auth
    include Spree::Core::ControllerHelpers::Store
    include Spree::Core::ControllerHelpers::Common
    helper Spree::BaseHelper

    def index
      @contacts = Spree::Contact.all
    end

    def create
      message = Spree::Message.create(message_params)
      PostbotMailer.message_to_manager(message.id).deliver!
      head :ok
    end

    private

    def message_params
      params.permit(:reason, :email, :address, :name, :phone, :message)
    end
  end
end
