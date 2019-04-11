module Spree
  class KnowledgeCentersController < Spree::BaseController
    include Spree::Core::ControllerHelpers::Order
    include Spree::Core::ControllerHelpers::Auth
    include Spree::Core::ControllerHelpers::Store
    include Spree::Core::ControllerHelpers::Common
    helper Spree::BaseHelper

    def show
      @questions = Spree::Question.all
      if params[:s].present?
        @questions = @questions.where('question ILIKE :s',
                                      s: "%#{params[:s]}%")
      end
      if params[:kind].present? && taxon = Spree::Taxon.find(params[:kind])
        @questions = @questions.where(category_id: taxon.id)
      end
    end
  end
end
