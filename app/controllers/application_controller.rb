class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  protect_from_forgery with: :exception

  def render_404(_exception = nil)
    respond_to do |type|
      type.html { render status: :not_found, file: "#{::Rails.root}/app/views/spree/error/not_found", formats: [:html] }
      type.all  { head :not_found }
    end
  end
end
