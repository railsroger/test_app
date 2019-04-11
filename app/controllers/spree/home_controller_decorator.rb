Spree::HomeController.class_eval do
  def index
    @hero_slides = Spree::HeroSlide.limit(7)
    if show_on_main_taxonomy = Spree::Taxonomy.find_by(name: 'Show on main page')
      @promoted_products = Spree::Product.in_taxon(show_on_main_taxonomy.root).limit 4
    end
    @company_block = Spree::CompanyBlock.find(1)
  end

  def robots
    render plain: current_store.robots
  end
end
