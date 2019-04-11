Spree::ProductsController.class_eval do
  def index
    @searcher = build_searcher(params.merge(include_images: true))
    @products = @searcher.retrieve_products
    @products = @products.includes(:possible_promotions) if @products.respond_to?(:includes)
    @taxonomies = Spree::Taxonomy.includes(root: :children)

    @small_products = @products.small_preview.to_a
    @big_products = @products.big_preview.to_a
  end

  def show
    @variants = @product.variants_including_master.spree_base_scopes.
                active(current_currency).includes(%i[option_values images])
    @product_properties = @product.product_properties.includes(:property)

    @taxon = if params[:taxon_id].present?
               Spree::Taxon.find(params[:taxon_id])
             else
               @product.taxons.first
             end
    redirect_if_legacy_path
  end

  def render_404(_exception = nil)
    respond_to do |type|
      type.html { render status: :not_found, file: "#{::Rails.root}/app/views/spree/error/not_found", formats: [:html] }
      type.all  { head :not_found }
    end
  end
end
