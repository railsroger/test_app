module Spree
  class SponsorshipsController < Spree::BaseController
    include Spree::Core::ControllerHelpers::Order
    include Spree::Core::ControllerHelpers::Auth
    include Spree::Core::ControllerHelpers::Store
    include Spree::Core::ControllerHelpers::Common
    helper Spree::BaseHelper

    def index
      @sponsorships = Spree::Sponsorship.all
    end

    def show
      @sponsorship = Spree::Sponsorship.find_by(slug: params[:id])
    end
  end
end
