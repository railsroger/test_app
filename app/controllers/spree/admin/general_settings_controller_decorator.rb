Spree::Admin::GeneralSettingsController.class_eval do
  def store_params
    params.require(:store).permit!
  end
end
