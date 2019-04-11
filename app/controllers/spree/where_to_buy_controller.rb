module Spree
  class WhereToBuyController < Spree::BaseController
    include Spree::Core::ControllerHelpers::Order
    include Spree::Core::ControllerHelpers::Auth
    include Spree::Core::ControllerHelpers::Store
    include Spree::Core::ControllerHelpers::Common
    helper Spree::BaseHelper

    def index
      @online_stores = Spree::OnlineStore.all
      @offline_stores = Spree::OfflineStore.all
    end
  end
end
