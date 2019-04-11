module Spree
  class SearchController < Spree::BaseController
    include Spree::Core::ControllerHelpers::Order
    include Spree::Core::ControllerHelpers::Auth
    include Spree::Core::ControllerHelpers::Store
    include Spree::Core::ControllerHelpers::Common
    helper Spree::BaseHelper

    def index
      return unless params[:keywords].present?
      @searcher = build_searcher(params.merge(include_images: true))
      @products = @searcher.retrieve_products
      @products = @products.where('name ILIKE ?', "%#{params[:keywords]}%") if params[:keywords].present?
      @products = @products.includes(:possible_promotions) if @products.respond_to?(:includes)

      @news = Spree::News.published.where('title ILIKE :s OR text ILIKE :s', s: "%#{params[:keywords]}%").limit(20)
    end
  end
end
