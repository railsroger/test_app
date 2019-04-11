module Spree
  class LegalPagesController < Spree::BaseController
    include Spree::Core::ControllerHelpers::Order
    include Spree::Core::ControllerHelpers::Auth
    include Spree::Core::ControllerHelpers::Store
    include Spree::Core::ControllerHelpers::Common
    helper Spree::BaseHelper

    def show
      @page = Spree::LegalPage.find_by(slug: params[:id])
    end
  end
end
