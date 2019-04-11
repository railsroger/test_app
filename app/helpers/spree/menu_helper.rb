module Spree
  module MenuHelper
    def categories
      Spree::Taxonomy.find_or_initialize_by(name: 'Categories').root.children
    end

    def popular_searches
      Spree::PopularSearch.all
    end

    def left_menu_items
      Spree::LeftMenuItem.active.map { |m| [m.name, m.url] }
    end

    def right_menu_items
      Spree::RightMenuItem.active.map { |m| [m.name, m.url] }
    end

    def right_bottom_menu_items
      right_top_menu_items
    end

    def right_top_menu_items
      right_menu_items
    end

    def hisense_global_url
      'http://global.hisense.com'
    end

    def legal_pages_items
      Spree::LegalPage.all.reduce({}) do |total, page|
        total.update(page.title => "/#{page.slug}")
      end
    end
  end
end
