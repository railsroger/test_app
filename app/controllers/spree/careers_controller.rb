module Spree
  class CareersController < Spree::BaseController
    def index
      @careers = Spree::Career.all
    end
  end
end
