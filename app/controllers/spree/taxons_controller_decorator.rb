Spree::TaxonsController.class_eval do
  include Spree::MenuHelper

  def show
    @taxon = Spree::Taxon.friendly.find(params[:id])
    return unless @taxon

    @searcher = build_searcher(params.merge(taxon: @taxon.id, include_images: true))
    @products = @searcher.retrieve_products
    @taxonomies = Spree::Taxonomy.includes(root: :children)

    @design_taxon = nil
    parent = @taxon
    until parent.nil?
      @design_taxon = parent if categories.include?(parent)
      parent = parent.parent
    end

    @design_taxon.applicable_filters.each do |filter|
      value = params[:filter][filter[:scope]]
      next if value.blank?
      value = URI.decode(value)
      property = Spree::Property.find_by(name: filter[:scope])
      ids = Spree::ProductProperty.where(property_id: property.id, value: value).pluck(:product_id)
      @products = @products.where(id: ids)
    end if params[:filter]

    if params[:count]
      render json: { count: t('spree.products.filter.results', count: @products.size) } and return
    end

    if categories.include?(@taxon) && params[:filter].blank?
      @small_products = @products.small_preview.to_a
      @big_products = @products.big_preview.to_a
    else
      @small_products = @products.to_a
      @big_products = []
    end

    render 'spree/products/index'
  end
end
