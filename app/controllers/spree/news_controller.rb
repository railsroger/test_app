# frozen_string_literal: true

module Spree
  class NewsController < Spree::BaseController
    include Spree::Core::ControllerHelpers::Order
    include Spree::Core::ControllerHelpers::Auth
    include Spree::Core::ControllerHelpers::Store
    include Spree::Core::ControllerHelpers::Common
    helper Spree::BaseHelper

    def index
      if params[:id].present?
        @sponsorship = Spree::Sponsorship.find_by!(slug: params[:id])
        @news = @sponsorship.news
      else
        @categories = Spree::NewsCategory.all
        @news = Spree::News.published
        @news = @news.where('title ILIKE :s OR text ILIKE :s', s: "%#{params[:s]}%") if params[:s].present?
        @news = @news.where(category_id: params[:category_id]) if params[:category_id].present?
        @news = @news.to_a
      end
    end

    def show
      @news = Spree::News.published.find_by(slug: params[:id])
    end
  end
end
