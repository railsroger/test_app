module Spree
  class DownloadsController < Spree::BaseController
    include Spree::Core::ControllerHelpers::Order
    include Spree::Core::ControllerHelpers::Auth
    include Spree::Core::ControllerHelpers::Store
    include Spree::Core::ControllerHelpers::Common
    helper Spree::BaseHelper

    def index
      return unless params[:s].present?
      @downloads = Spree::Download.where('name ILIKE :s OR description ILIKE :s',
                                         s: "%#{params[:s]}%")
      @downloads = @downloads.where(category_id: params[:kind]) if params[:kind].present?
    end
  end
end
