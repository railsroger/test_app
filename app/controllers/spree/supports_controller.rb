module Spree
  class SupportsController < Spree::BaseController
    include Spree::Core::ControllerHelpers::Order
    include Spree::Core::ControllerHelpers::Auth
    include Spree::Core::ControllerHelpers::Store
    include Spree::Core::ControllerHelpers::Common
    helper Spree::BaseHelper

    def show
      @product = Spree::Product.find_by(model_number: params[:model_number]) if params[:model_number]
    end
  end
end
