module Spree
  class SubscribersController < Spree::BaseController
    def create
      Spree::Subscriber.find_or_create_by!(subscriber_params)
      head :ok
    end

    private

    def subscriber_params
      params.permit(:email)
    end
  end
end
