Spree::Admin::ProductsController.class_eval do
  def taxon_params
    params.require(:product).permit!
  end
end
