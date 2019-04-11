# frozen_string_literal: true

namespace :db do
  desc 'Sync data like categories, settings etc'
  task sync: :environment do

    Spree::ShippingCategory.first || Spree::ShippingCategory.create(name: 'Default')

    # Store
    puts 'Configuring store..'
    current_store = Spree::Store.first
    current_store.name = 'Hisense'
    current_store.mail_from_address = 'noreply@hisense.com'
    current_store.url = Rails.env.development? ? '0.0.0.0:3000' : 'hisense-seetheincredible.com'
    current_store.country = Spree::Country.find_by(iso3: 'RUS')
    current_store.save!

    # Taxons: Category
    puts 'Creating categories..'
    categories_taxonomy = Spree::Taxonomy.find_or_initialize_by(name: 'Categories').tap(&:save!)

    [['Televisions', 'icon-tv'], ['Refrigerators', 'icon-fridge'], ['Mobile', 'icon-phone'], ['Washers', 'icon-laundry']].each do |e|
      taxon_name = e[0]
      support_icon = e[1]
      taxon_params = { name: taxon_name, parent_id: categories_taxonomy.root.id }
      taxon = Spree::Taxon.find_by(taxon_params) ||
              Spree::Taxon.new(taxon_params.merge(child_index: 1))
      taxon.taxonomy_id = categories_taxonomy.id
      taxon.description = "Plenty of choice\r\nto find the best fit for your home"
      taxon.bg_color = %w[Televisions Mobile].include?(taxon_name) ? '#000' : '#fff'
      taxon.ui_black = %w[Televisions Mobile].include?(taxon_name)
      taxon.support_icon = support_icon
      image_file = File.open('public/images/catalog/banner-image.png')
      taxon.image = image_file
      image_file.close
      bg_image_file = File.open('public/images/catalog/banner-background.jpg')
      taxon.bg_image = bg_image_file unless %w[Televisions Mobile].include?(taxon_name)
      bg_image_file.close
      taxon.save!
    end

    # Taxons: Product Series
    puts 'Creating product series..'
    series_taxonomy = Spree::Taxonomy.find_or_initialize_by(name: 'Product Series').tap(&:save!)

    { Televisions: %w[U7 U9] }.each do |category|
      taxon_params = { name: category[0], parent_id: series_taxonomy.root.id }
      category_taxon = Spree::Taxon.find_by(taxon_params) ||
                       Spree::Taxon.new(taxon_params.merge(child_index: 1))
      category_taxon.taxonomy_id = series_taxonomy.id
      category_taxon.save!

      category[1].each do |series_name|
        taxon_params = { name: series_name, parent_id: category_taxon.id }
        taxon = Spree::Taxon.find_by(taxon_params) ||
                Spree::Taxon.new(taxon_params.merge(child_index: 2))
        taxon.taxonomy_id = series_taxonomy.id
        taxon.save!
      end
    end

    # Taxons: Promouted products
    puts 'Creating Show on main page taxon..'
    show_on_main_taxonomy = Spree::Taxonomy.find_or_initialize_by(name: 'Show on main page').tap(&:save!)

    # Questions
    puts 'Creating questions..'
    [%w[TV TV], %w[Refregerator Refrigeration], %w[Mobile Mobile], %w[Washer Laundry]].each do |cat|
      question_text = "What is the code for my sky/virgin remote control for my #{cat[0]}?"
      question = Spree::Question.find_by(question: question_text) ||
                 Spree::Question.new(question: question_text)
      question.answer = 'This depends on the remote controller, specific to each TV model. Please call the service centre on 0333 800 2200, who will be happy to provide you with the correct code.'
      question.kind = cat[1]
      question.save!
    end

    # Hero Slides
    puts 'Creating hero slider..'
    hero_slide = Spree::HeroSlide.find_by(id: 1) ||
                 Spree::HeroSlide.new(id: 1)
    hero_slide.title = 'Awesome color'
    hero_slide.link = '/'
    hero_slide.title_horizontal_align = 'center'
    hero_slide.title_vertical_align = 'bottom'
    hero_slide.position = 1
    unless hero_slide.video?
      video_file = File.open('public/content/main_hero/fridge-color.mp4')
      hero_slide.video = video_file
      video_file.close
    end
    image_file = File.open('public/content/main_hero/fridge-color.png')
    hero_slide.image = image_file
    image_file.close
    hero_slide.save!

    hero_slide = Spree::HeroSlide.find_by(id: 2) ||
                 Spree::HeroSlide.new(id: 2)
    hero_slide.title = 'Hisense 4K TV'
    hero_slide.link = '/'
    hero_slide.title_horizontal_align = 'left'
    hero_slide.title_vertical_align = 'center'
    hero_slide.position = 2
    unless hero_slide.video?
      video_file = File.open('public/content/main_hero/uled-tv.mp4')
      hero_slide.video = video_file
      video_file.close
    end
    image_file = File.open('public/content/main_hero/uled-tv.jpg')
    hero_slide.image = image_file
    image_file.close
    hero_slide.save!

    hero_slide = Spree::HeroSlide.find_by(id: 3) ||
                 Spree::HeroSlide.new(id: 3)
    hero_slide.title = 'ROKU TV'
    hero_slide.link = '/'
    hero_slide.title_horizontal_align = 'right'
    hero_slide.title_vertical_align = 'center'
    hero_slide.position = 2
    unless hero_slide.video?
      video_file = File.open('public/content/main_hero/roku-tv.mp4')
      hero_slide.video = video_file
      video_file.close
    end
    image_file = File.open('public/content/main_hero/roku-tv.jpg')
    hero_slide.image = image_file
    image_file.close
    hero_slide.save!


    # Company blocks
    puts 'Creating company block..'
    company_block = Spree::CompanyBlock.find_by(id: 1) ||
                    Spree::CompanyBlock.create!(id: 1)
    company_block.is_active = true
    company_block.main_statement = 'hisense perfect <br> quality'
    company_block.video_statement = 'Pushing <br> the boundaries <br> of innovation since <br> 1969.'
    unless company_block.video?
      video_file = File.open('public/content/company/hisense-mov.mp4')
      company_block.video = video_file
      video_file.close
    end
    video_cover_file = File.open('public/content/company/hisense-mov.jpg')
    company_block.video_cover = video_cover_file
    video_cover_file.close
    company_block.save!
    # Company blocks sections
    ['Overview', 'N1 China', 'Hisense now',
     'Histiry', 'Sponsorship'].each_with_index do |v, i|
      section = Spree::CompanyBlockSection.find_by(id: i) ||
                Spree::CompanyBlockSection.create!(id: i, company_block_id: 1)
      section.position = i
      section.name = v
      section.link = '/'
      section.save!
    end


    # Legal pages
    puts 'Creating legal pages..'
    ['Privacy Policy', 'Company Information'].each_with_index do |title, index|
      page = Spree::LegalPage.find_by(title: title) ||
             Spree::LegalPage.new(title: title)
      page.position = index
      page.html = "<h2>#{title}</h2>\r\n<p>Test here.</p>"
      page.save!
    end

    # Flags
    puts 'Configuring countries..'
    Spree::Country.all.reorder(iso3: :asc).each_with_index do |c, i|
      c.update_attribute :position, i
    end
    { 'argentina' => 'ARG', 'australia' => 'AUS', 'canada' => 'CAN', 'france' => 'FRA', 'norway' => 'NOR', 'russia' => 'RUS', 'switzerland' => 'CHE' }.each do |c|
      country = Spree::Country.find_by(iso3: c.last)
      country.display = true
      country.link = '/'
      flag_file = File.open("public/images/flags/#{c.first}.jpg")
      country.flag = flag_file
      flag_file.close
      country.save!
    end

    # Company pages
    puts 'Creating company pages..'
    [
      { id: 1, position: 1, title: 'Company', header: "For\r\nyour home\r\nnothing makes\r\nmore sense", text: '', image_file_name: 'about-start-cover.jpg', page_type: 'cover_section' },
      { id: 2, position: 2, title: 'Discover', header: "Pushing the\r\nboundaries of\r\ninnovation since\r\n1969", text: '<p>For almost 5 decades Hisense have been committe...', page_type: 'text_section' },
      { id: 3, position: 3, title: 'Qualuty', header: "Our commitment\r\nto quality", text: '<p>We want you to love your Hisense products. Not ...', image_file_name: 'about-quality-cover.jpg', page_type: 'header_image' },
      { id: 4, position: 4, title: 'Innovation', header: "Innovation\r\nthrough\r\nexperience", text: '<p>Since 1969, we have been striving to push the b...', image_file_name: 'about-innovation-cover.jpg', page_type: 'main_text_image' }
    ].each do |page|
      company_page = Spree::CompanyPage.find_by(id: page[:id]) ||
                     Spree::CompanyPage.new(id: page[:id])
      image_file_name = page.delete(:image_file_name)
      company_page.assign_attributes(page)
      unless image_file_name.nil?
        image_file = File.open("public/images/#{image_file_name}")
        company_page.image = image_file
        image_file.close
      end
      company_page.save!
    end

    # Sponsorship
    puts 'Creating sponsorships..'
    [{ id: 1, title: 'The World Cup 2018', image: '/images/sponsorship-slide-1.jpg' },
     { id: 2, title: 'USA Soccer', image: '/images/sponsorship-slide-2.jpg' },
     { id: 3, title: 'Lions FC Rugby Club', image: '/images/sponsorship-slide-3.jpg' },
     { id: 4, title: 'Evil Geniuses EGames Team', image: '/images/sponsorship-slide-4.jpg' },
     { id: 5, title: 'People Are Awesome', image: '/images/sponsorship-slide-5.jpg' },
     { id: 6, title: 'Aston Villa Football Club', image: '/images/sponsorship-slide-6.jpg' }].each do |item|
      sponsorship = Spree::Sponsorship.find_by(id: item[:id]) ||
                    Spree::Sponsorship.new(id: item[:id])
      sponsorship.name = item[:title]
      sponsorship.slogan = "Immerse\r\nyourself\r\nin the action"
      sponsorship.text = "<div class=\"page__subtitle\">World class ways to<br>watch the 2018 FIFA<br>World Cup</div><div class=\"page__text\"><p>When you’re watching world class players at the top of their game, you want to see the incredible, incredibly. So, we've pulled together some top tips to enhance the viewing experience on your Hisense TV. Follow these and feast your eyes on a World Cup to remember.</p></div>"
      main_image_file = File.open('public/images/sponsorship-cover.jpg')
      sponsorship.main_image = main_image_file
      main_image_file.close
      preview_image_file = File.open("public/images/sponsorship-slide-#{item[:id]}.jpg")
      sponsorship.preview_image = preview_image_file
      preview_image_file.close
      pattern_image_file = File.open('public/images/sponsorship-head-cover.jpg')
      sponsorship.pattern_image = pattern_image_file
      pattern_image_file.close
      sponsorship.save!
    end

    # Contact
    puts 'Creating contacts..'
    %w[Warranty TV Refrigeration Laundry].each_with_index do |title, i|
      contact = Spree::Contact.find_by(title: title) ||
                Spree::Contact.new(title: title)
      contact.position = i + 1
      contact.phone = "0333 800 220#{i}"
      contact.working_hours_mon_sat = '8am - 7pm'
      contact.working_hours_sun = '10AM - 4PM'
      contact.text = "If your enquiry relates to a product\r\nthat has already been purchased,\r\n please provide us with your model\r\n & serial numbers to enable us to deal\r\n with your enquiry more effictively."
      contact.faq_text = 'Where can I find my serial number?'
      contact.faq_link = 'http://ya.ru'
      contact.save!
    end

    # Download
    puts 'Creating downloads..'
    download = Spree::Download.find_by(name: 'Test file') ||
               Spree::Download.new(name: 'Test file')
    download.kind = 'patch'
    download.description = 'Try my out'
    download.version = '5.2.1'
    download.date = 5.days.ago
    file_file = File.open('public/images/sponsorship-head-cover.jpg')
    download.file = file_file
    file_file.close
    download.save!

    # Online Store
    puts 'Creating online stores..'
    store = Spree::OnlineStore.find_by(name: 'm2hagency.com') ||
            Spree::OnlineStore.new(name: 'm2hagency.com')
    store.url = 'http://m2hagency.com/'
    store.save!

    # Offline Store
    puts 'Creating offline stores..'
    store = Spree::OfflineStore.find_by(name: 'johnlewis') ||
            Spree::OfflineStore.new(name: 'johnlewis')
    store.address = 'Conklin Ave, 2602'
    store.pin_color = '#211adf'
    store.coordinates = '51.2, -0.09'
    store.save!

    # News categories
    puts 'Creating news categories..'
    { 'SPONSORSHIP' => 'blue', 'CORPORATE' => 'orange', 'PRODUCT' => 'red' }.each_with_index do |value, index|
      category = Spree::NewsCategory.find_by(name: value[0]) ||
                 Spree::NewsCategory.new(name: value[0])
      category.color = value[1]
      category.save!
    end

    # News
    puts 'Creating news..'
    Spree::Sponsorship.all.each_with_index do |sponsorship, index1|
      ['The World Cup 2018', 'USA Soccer', 'Lions FC Rugby Club',
       'Evil Geniuses EGames Team', 'People Are Awesome',
       'Aston Villa Football Club'].each_with_index do |title, index|
        news = Spree::News.find_by(id: 6 * index1 + index + 1) ||
               Spree::News.new(id: 6 * index1 + index + 1)
        news.title = title
        news.is_published = true
        news.category_id = Spree::NewsCategory.pluck(:id).sample
        news.published_on = (6 * index1 + index).days.ago
        news.sponsorship = sponsorship
        news.text_raw = 'Text will be here'
        list_image_file = File.open("public/images/sponsorship-slide-#{index + 1}.jpg")
        news.list_image = list_image_file
        list_image_file.close
        main_image_file = File.open('public/images/sponsorship-cover.jpg')
        news.main_image = main_image_file
        main_image_file.close

        news_image1 = (Spree::Image.find_by(viewable_type: 'Spree::News', attachment_file_name: 'image1.jpg') || Spree::Image.create!(viewable_type: 'Spree::News', attachment: URI.parse("#{Spree::Store.first.url}/images/news/image1.jpg"))).attachment.url(:slider_small, timestamp: false)
        news_image2 = (Spree::Image.find_by(viewable_type: 'Spree::News', attachment_file_name: 'image2.jpg') || Spree::Image.create!(viewable_type: 'Spree::News', attachment: URI.parse("#{Spree::Store.first.url}/images/news/image2.jpg"))).attachment.url(:slider_small, timestamp: false)

        news.text_raw = '<p>
            In Australia, we love playing video games. In fact, nearly 70 per cent of Australians do some gaming, according to the most recent study from the Interactive Games and Entertainment Association.And while we like to use tablets and phones to game when we’re out and about, we still love sitting to down to play when we’re home. But what are the best games to play on a TV?
          </p>
          <p>
            <gallery urls="' + Spree::Store.first.url + news_image2 + '|' + Spree::Store.first.url + news_image1 + '"></gallery>
          </p>
          <p>
            Some games genres are great to play on a TV while some just don’t work quite as well. Here’s a brief rundown of which is which.Using your TV is arguably the only way to play party games. Whether it’s Guitar Hero, Singstar, Wii Sports or, er, Johann Sebastian Joust, having the space of a lounge room and a screen large enough that everybody can see from behind the sofa is essential for getting the best out of these timeless favourites.
          </p>
          <h2>FIRST PERSON SHOOTERS</h2>
          <p>
            The FPS as it’s better known can be a little contentious. The PC gaming purists will say that only a mouse and keyboard can get you the precision you need. For the more competitive games like Counter-Strike they might be right but single player FPS action adventures are perfect on the TV.
          </p>
          <p>
            <img src="' + news_image1 + '" alt="Game Console PS4">
          </p>
          <p>
            Consider the upcoming game Far Cry 5 from Ubisoft. That’s going be available in Ultra HD with 4K for the Xbox One X, which means it’ll look absolutely amazing on a 4K TV. If you want something more than a plank of wood to balance your peripherals on, the Corsair Lapdog might be some use.
          </p>
          <h2>RACING GAMES</h2>
          <p>
            Whether it’s Formula 1, World Rally Championship or down-and-dirty street racing, these high-octane games have always been popular on home consoles. The latest tech makes it more realistic than ever and if you’re not going to disturb anyone else, why not ditch the gaming headphones, fire up the surround sound or soundbar and just let that engine noise wash over you.
          </p>
          <p>
            Both Forza 7 for Xbox and Gran Turismo Sport on the PlayStation – the classics when it comes to the racing genre – have been given an HDR graphics boost and the results speak for themselves. 1212
          </p>'
        news.save!
      end
    end

    # Popular searches
    puts 'Creating popular searches..'
    ['Popular', 'SERIES U8', '2018 WORLD CUP FIFA EDITION', 'MODEL NO 667U8'].each do |search|
      Spree::PopularSearch.find_or_create_by!(text: search)
    end

    [{ id: 1, title: 'The World Cup 2018', image: '/images/sponsorship-slide-1.jpg' },
     { id: 2, title: 'USA Soccer', image: '/images/sponsorship-slide-2.jpg' },
     { id: 3, title: 'Lions FC Rugby Club', image: '/images/sponsorship-slide-3.jpg' },
     { id: 4, title: 'Evil Geniuses EGames Team', image: '/images/sponsorship-slide-4.jpg' },
     { id: 5, title: 'People Are Awesome', image: '/images/sponsorship-slide-5.jpg' },
     { id: 6, title: 'Aston Villa Football Club', image: '/images/sponsorship-slide-6.jpg' }].each do |item|
      sponsorship = Spree::Sponsorship.find_by(id: item[:id]) ||
                    Spree::Sponsorship.new(id: item[:id])
      sponsorship.name = item[:title]
      sponsorship.slogan = "Immerse\r\nyourself\r\nin the action"
      sponsorship.text = "<div class=\"page__subtitle\">World class ways to<br>watch the 2018 FIFA<br>World Cup</div><div class=\"page__text\"><p>When you’re watching world class players at the top of their game, you want to see the incredible, incredibly. So, we've pulled together some top tips to enhance the viewing experience on your Hisense TV. Follow these and feast your eyes on a World Cup to remember.</p></div>"
      main_image_file = File.open('public/images/sponsorship-cover.jpg')
      sponsorship.main_image = main_image_file
      main_image_file.close
      preview_image_file = File.open("public/images/sponsorship-slide-#{item[:id]}.jpg")
      sponsorship.preview_image = preview_image_file
      preview_image_file.close
      pattern_image_file = File.open('public/images/sponsorship-head-cover.jpg')
      sponsorship.pattern_image = pattern_image_file
      pattern_image_file.close
      sponsorship.save!
    end


    # Properties
    puts 'Creating properties..'
    [['Model', ['Made with', 'With sound']], ['Screen', ['Is super']]].each do |props|
      group, names = props
      names.each do |name|
        property = Spree::Property.find_by(presentation: name, group: group) ||
                   Spree::Property.new(presentation: name, group: group)
        property.name = name
        property.save!
      end
    end

    # Property Value Icons
    puts 'Creating property icons..'
    { 'Made with' => 'Leaf', 'With sound' => 'Yes', 'Is super' => 'Yes' }.each_with_index do |value, index|
      property_id = Spree::Property.find_by(presentation: value[0]).id
      icon = Spree::PropertyValueIcon.find_by(property_id: property_id, value: value[1]) ||
             Spree::PropertyValueIcon.new(property_id: property_id, value: value[1])
      white_icon_file = File.open("public/images/icons/white/#{index + 1}.png")
      icon.icon_white = white_icon_file
      white_icon_file.close
      dark_icon_file = File.open("public/images/icons/black/#{index + 1}.png")
      icon.icon_dark = dark_icon_file
      dark_icon_file.close
      icon.save!
    end

    # Products
    %w[Televisions Refregerators Mobile Washers].each do |category|
      (1..25).each do |i|
        puts "Creating product #{category} #{i}.."
        name = "Hisense 4K ULED #{category} (64.5\"diag.) #{i}"
        product = Spree::Product.find_by(name: name) ||
                  Spree::Product.new

        product.shipping_category = Spree::ShippingCategory.first
        product.name = name
        product.price = 2799
        product.description = ''
        product.available_on = 1.day.ago
        product.meta_description = ''
        product.meta_keywords = ''
        product.tax_category_id = nil
        product.shipping_category_id = 1
        product.meta_title = 'Hisense 4K ULED Smart TV | World Cup Limited Edition'
        product.discontinue_on = nil
        product.is_new = true
        product.big_preview = (i % 4).zero?

        preview_image_file = File.open('public/images/catalog/item-3.png')
        product.preview_image = preview_image_file
        preview_image_file.close

        product.preview_description = 'THE BEST FRIDGE DESCRIPTION'
        product.preview_features = "Electronic Temperature Control\r\n615 Total Capacity in Litres (Gross)\r\n433 Energy Consumption (kWh/year)\r\n912 x 1766 x 726 Dimensions in mm's (W x H x D)"
        product.hero_alignment_right = false
        product.hero_super_title = 'World Cup Limited Edition'
        product.hero_title = 'The World Cup like never before'

        hero_image_file = File.open('public/images/product/head-image.png')
        product.hero_image = hero_image_file
        hero_image_file.close

        hero_bg_image_file = File.open('public/images/product/head-bg.jpg')
        product.hero_bg_image = hero_bg_image_file
        hero_bg_image_file.close

        product.hero_bg_color = '#222'
        product.hero_ui_black = false


        video_cover_file = File.open('public/videos/video-2.jpg')
        product.video_cover = video_cover_file
        video_cover_file.close
        unless product.video?
          video_file = File.open('public/videos/video-2.mp4')
          product.video = video_file
          video_file.close
        end

        product.model_number = "SKDJ#{i * 13}#{category[2..4]}"
        product.model_year = '2017'
        product.disclaimer = '1A small gap between the wall and TV may occur if ...'

        product.save!

        # Product taxons
        puts 'Creating product taxons..'
        cat_taxon = Spree::Taxon.find_by(name: category, parent_id: categories_taxonomy.root.id)
        series_u7_taxon = if category == 'Televisions'
                            Spree::Taxon.find_by(name: 'Televisions', parent_id: series_taxonomy.root.id).children.find_by(name: 'U7')
                          end
        show_on_main_taxon = show_on_main_taxonomy.root

        [series_u7_taxon, cat_taxon, show_on_main_taxon].each do |taxon|
          next unless taxon
          product.classifications.find_by(taxon_id: taxon.id) ||
            product.classifications.create!(taxon_id: taxon.id)
        end

        # Product Properties
        puts 'Creating product properties..'
        { 'Made with' => 'Leaf', 'With sound' => 'Yes', 'Is super' => 'No' }.each do |value|
          property_id = Spree::Property.find_by(presentation: value[0]).id
          property = Spree::ProductProperty.find_by(product_id: product.id, property_id: property_id) ||
                     Spree::ProductProperty.new(product_id: product.id, property_id: property_id)
          property.value = value[1]
          property.save!
        end

        # Product Images
        puts 'Creating product images..'
        product = Spree::Product.find_by(name: name)
        variant = product.master
        (1..6).each do |index|
          image = Spree::Image.find_by(viewable: variant, position: index) ||
                  Spree::Image.new(viewable: variant, position: index)
          attachment_file = File.open('public/images/product/hover-image.jpg')
          image.attachment = attachment_file
          attachment_file.close
          image.save!
        end

        # Product Content Blocks
        puts 'Creating product content blocks..'
        [
          { position: 1, hero_ui_black: true, is_active: true, color: '#fff', bg_color: '#222', name: 'Overview', bg_image_file_name: 'head-bg.jpg', built_in_block: nil, html: "<div id=\"overview\" class=\"html-block\" data-ui-white>\r\n<div class=\"html-block__container html-block__container_align_center\">\r\n<img src=\"/images/product/logo.png\" />\r\n<div class=\"html-block__title\">The ultimate 4K experience</div>\r\n<div class=\"html-block__text\">\r\n<p>\r\nUltra Colour, Ultra Contrast, Ultra Smooth Motion and 4K Ultra HD work in harmony to bring you\r\nsmoother, more fluid picture quality that bursts with colour, clarity and striking contrast.\r\n</p>\r\n</div>\r\n<img src=\"/images/product/tv.png\" />\r\n</div>\r\n</div>\r\n" },
          { position: 2, hero_ui_black: true, is_active: true, color: '#fff', bg_color: '#222', name: 'Ultra Color', bg_image_file_name: 'hover-image.jpg', built_in_block: nil, html: "\r\n<div class=\"bright-block\">\r\n<div class=\"bright-block__cover\" style=\"background-image: url('/images/sponsorship-slide-1.jpg')\"></div>\r\n<div class=\"bright-block__cover\" style=\"background-image: url('/images/sponsorship-slide-2.jpg')\"></div>\r\n<div class=\"bright-block__cover\" style=\"background-image: url('/images/sponsorship-slide-3.jpg')\"></div>\r\n<div class=\"bright-block__cover\" style=\"background-image: url('/images/sponsorship-slide-4.jpg')\"></div><div class=\"bright-block__column\">\r\n<div class=\"bright-block__head\">+</div>\r\n<div class=\"bright-block__content\">\r\n<div class=\"bright-block__title\">Ultra Color</div>\r\n<div class=\"bright-block__text\">See more colors than ever before</div>\r\n</div>\r\n</div>\r\n<div class=\"bright-block__column\">\r\n<div class=\"bright-block__head\">+</div>\r\n<div class=\"bright-block__content\">\r\n<div class=\"bright-block__title\">Ultra Color</div>\r\n<div class=\"bright-block__text\">See more colors than ever before</div>\r\n</div>\r\n</div>\r\n<div class=\"bright-block__column\">\r\n<div class=\"bright-block__head\">+</div>\r\n<div class=\"bright-block__content\">\r\n<div class=\"bright-block__title\">Ultra Color</div>\r\n<div class=\"bright-block__text\">See more colors than ever before</div>\r\n</div>\r\n</div>\r\n<div class=\"bright-block__column\">\r\n<div class=\"bright-block__head\">+</div>\r\n<div class=\"bright-block__content\">\r\n<div class=\"bright-block__title\">Ultra Constrast</div>\r\n<div class=\"bright-block__text\">For striking levels of brightness, darkness, contrast and depth</div>\r\n</div>\r\n</div>\r\n</div>\r\n" },
          { position: 3, hero_ui_black: true, is_active: true, color: '#000', bg_color: '#fff', name: 'Breakthrough features all around', built_in_block: nil, html: "<div class=\"html-block\">\r\n<div class=\"html-block__row\">\r\n<div class=\"html-block__column\">\r\n<div class=\"html-block__container html-block__container_size_small\">\r\n<div class=\"html-block__title\">Breakthrough features all around</div>\r\n<div class=\"html-block__text\">\r\n<p>The Hisense U9 series ULED TV is a masterpiece at every level.Not just hand crafted and assembled by artisans around the world,the U9 boasts the best in display technology at a fraction of the cost.</p>\r\n</div>\r\n<table>\r\n<tbody>\r\n<tr>\r\n<td>\r\n<strong>4K Ultra HD</strong>\r\n<p>3084x2160 resolutionfor supreme clarity</p>\r\n</td>\r\n<td>\r\n<strong>4K Ultra HD</strong>\r\n<p>3084x2160 resolutionfor supreme clarity</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td>\r\n<strong>4K Ultra HD</strong>\r\n<p>3084x2160 resolutionfor supreme clarity</p>\r\n</td>\r\n<td>\r\n<strong>4K Ultra HD</strong>\r\n<p>3084x2160 resolutionfor supreme clarity</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</div>\r\n</div>\r\n<div class=\"html-block__column\">\r\n<img src=\"/images/product/tv.png\">\r\n</div>\r\n</div>\r\n</div>" },
          { position: 4, hero_ui_black: nil, is_active: true, color: nil, bg_color: nil, name: 'Gallery', html: nil, built_in_block: 'gallery' },
          { position: 5, hero_ui_black: false, is_active: true, color: '#000', bg_color: '#fff', name: 'The brightest and most vivid colours', bg_image_file_name: 'tv-bg.jpg', built_in_block: nil, html: "<div class=\"html-block html-block_mobile-bg_white\">\r\n<div class=\"html-block__row html-block__row_height_large\">\r\n<div class=\"html-block__column\"></div>\r\n<div class=\"html-block__column\">\r\n<div class=\"html-block__container html-block__container_size_small html-block__container_align_center\">\r\n<img src=\"/images/product/title.png\">\r\n<div class=\"html-block__text\">\r\n<p>The brightest and most vivid colours imaginable deliveredwith absolute black contrast, lets Hisense ULED TVs reproducecinematic imagery true to the original source.</p>\r\n</div>\r\n<img src=\"/images/product/description.png\">\r\n</div>\r\n</div>\r\n</div>\r\n</div>" },
          { position: 6, hero_ui_black: true, is_active: true, color: '#fff', bg_color: '#151515', name: 'HDR Plus', built_in_block: nil, html: "<div class=\"html-block\">\r\n<div class=\"html-block__container html-block__container_align_center\">\r\n<div class=\"html-block__title\">HDR Plus. Enhanced clarity, light, detail and colour.</div>\r\n<div class=\"html-block__text\">\r\n<p>HDR Plus takes your viewing experience to a whole new level. Not only does it dramatically enhanceevery detail, it also boosts contrast and colour accuracy for incredibly true-to-life colours and superb levels of clarity.</p>\r\n</div>\r\n</div>\r\n</div>" },
          { position: 7, hero_ui_black: true, is_active: true, color: '', bg_color: '', name: 'HDR Plus comparison', built_in_block: nil, html: "<div class=\"image-comparison\"><img src=\"/images/product/photo-1.jpg\" data-label=\"ULED with <span style='color: #45db93'>HDR Plus</span>\"><img src=\"/images/product/photo-2.jpg\" data-label=\"Normal\"><div class=\"image-comparison__title\"><div class=\"image-comparison__title-inner\">PIN SHARP<br>STUNNINGLY<br>REALISTIC PICTURE<br>QUALITY</div> </div></div>" },
          { position: 8, hero_ui_black: true, is_active: true, color: '#000', bg_color: '#fff', name: 'High-performance techpacked', bg_image_file_name: 'tv-bg2.jpg', built_in_block: nil, html: "<div class=\"html-block html-block_mobile-bg_white\">\r\n<div class=\"html-block__row html-block__row_height_large\">\r\n<div class=\"html-block__column\">\r\n<div class=\"html-block__container html-block__container_size_small\">\r\n<div class=\"html-block__title\">High-performance techpacked tight into anultra-sleek design.</div>\r\n<div class=\"html-block__text\">\r\n<p>High-performance technology in an elegant, ultra slim design featuring, 3 USB portsand 4 HDMI ports, so your television will fit effortlessly into any environment.</p>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>" },
          { position: 9, hero_ui_black: true, is_active: true, color: '', bg_color: '', name: 'Smart TV', built_in_block: nil, html: '<img class="product__full-image" data-ui-white="" src="/images/product/smart-tv.jpg">' },
          { position: 10, hero_ui_black: true, is_active: true, color: '', bg_color: '', name: 'Specifications', built_in_block: nil, html: "<div class=\"specs-block\" id=\"specifications\">\r\n<div class=\"specs-block__title\">\r\nNow, here’s the <strong>technical bit...</strong>\r\n</div>\r\n<div class=\"specs-block__text\">Below, you’ll find all the technical details, such as dimension etc</div>\r\n<div class=\"specs-block__list\">\r\n<div class=\"specs-block__line\">\r\n<div class=\"specs-block__item\">\r\n<div class=\"specs-block__item-title\">\r\n178 <sup>o</sup>\r\n</div>\r\n<div class=\"specs-block__item-text\">Angle of Visibility</div>\r\n</div>\r\n<div class=\"specs-block__item\">\r\n<div class=\"specs-block__item-title\">50”-75”</div>\r\n<div class=\"specs-block__item-text\">Screen Size</div>\r\n</div>\r\n<div class=\"specs-block__item\">\r\n<div class=\"specs-block__item-title\">3840x2160</div>\r\n<div class=\"specs-block__item-text\">Ultra HD Resolution</div>\r\n</div>\r\n</div>\r\n<div class=\"specs-block__line\">\r\n<div class=\"specs-block__item\">\r\n<div class=\"specs-block__item-title\">ELED</div>\r\n<div class=\"specs-block__item-text\">Backlight Type</div>\r\n</div>\r\n<div class=\"specs-block__item\">\r\n<div class=\"specs-block__item-title\">8bit+FRC</div>\r\n<div class=\"specs-block__item-text\">Panel Bit Depth</div>\r\n</div>\r\n<div class=\"specs-block__item\">\r\n<div class=\"specs-block__item-title\">&lt;50ms</div>\r\n<div class=\"specs-block__item-text\">Input Lag</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>" },
          { position: 12, hero_ui_black: true, is_active: true, color: '', bg_color: '', name: 'Reviews slider', built_in_block: nil, html: "<section class=\"reviews-slider\" data-ui-white=\"\">\r\n<div class=\"reviews-slider__container swiper-container swiper-container-horizontal\">\r\n<button class=\"reviews-slider__navigation reviews-slider__navigation_left\" type=\"button\" tabindex=\"0\" role=\"button\" aria-label=\"Previous slide\"></button>\r\n<button class=\"reviews-slider__navigation reviews-slider__navigation_right\" type=\"button\" tabindex=\"0\" role=\"button\" aria-label=\"Next slide\"></button>\r\n<div class=\"swiper-wrapper\" style=\"transform: translate3d(-1394px, 0px, 0px); transition-duration: 0ms;\">\r\n<div class=\"reviews-slider__slide swiper-slide swiper-slide-duplicate swiper-slide-prev swiper-slide-duplicate-next\" data-swiper-slide-index=\"1\" style=\"width: 1394px;\">\r\n<div class=\"reviews-slider__slide-container\"><div class=\"reviews-slider__slide-text\">This is a fantastic fabulous TV.The picture is unbelievableand the functionality is superb.</div>\r\n<img class=\"reviews-slider__slide-image\" src=\"/images/product/review-logo.png\">\r\n</div>\r\n</div>\r\n<div class=\"reviews-slider__slide swiper-slide swiper-slide-active\" data-swiper-slide-index=\"0\" style=\"width: 1394px;\">\r\n<div class=\"reviews-slider__slide-container\">\r\n<div class=\"reviews-slider__slide-text\">This is a fantastic fabulous TV.The picture is unbelievableand the functionality is superb.</div>\r\n<img class=\"reviews-slider__slide-image\" src=\"/images/product/review-logo.png\">\r\n</div>\r\n</div>\r\n<div class=\"reviews-slider__slide swiper-slide swiper-slide-next swiper-slide-duplicate-prev\" data-swiper-slide-index=\"1\" style=\"width: 1394px;\">\r\n<div class=\"reviews-slider__slide-container\">\r\n<div class=\"reviews-slider__slide-text\">This is a fantastic fabulous TV.The picture is unbelievableand the functionality is superb.</div>\r\n<img class=\"reviews-slider__slide-image\" src=\"/images/product/review-logo.png\"></div>\r\n</div>\r\n<div class=\"reviews-slider__slide swiper-slide swiper-slide-duplicate swiper-slide-duplicate-active\" data-swiper-slide-index=\"0\" style=\"width: 1394px;\">\r\n<div class=\"reviews-slider__slide-container\">\r\n<div class=\"reviews-slider__slide-text\">This is a fantastic fabulous TV.The picture is unbelievableand the functionality is superb.</div>\r\n<img class=\"reviews-slider__slide-image\" src=\"/images/product/review-logo.png\">\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"swiper-pagination swiper-pagination-bullets\">\r\n<span class=\"swiper-pagination-bullet swiper-pagination-bullet-active\"></span>\r\n<span class=\"swiper-pagination-bullet\"></span>\r\n</div>\r\n<span class=\"swiper-notification\" aria-live=\"assertive\" aria-atomic=\"true\"></span>\r\n</div>\r\n</section>" },
          { position: 13, hero_ui_black: nil, is_active: true, color: nil, bg_color: nil, name: 'Video', built_in_block: 'video', html: nil },
          { position: 14, hero_ui_black: nil, is_active: true, color: nil, bg_color: nil, name: 'Support', built_in_block: 'support', html: nil },
          { position: 15, hero_ui_black: true, is_active: true, color: '#fff', bg_color: '#1a1a1a', name: 'Now in Stores', built_in_block: nil, html: "<div class=\"html-block\" data-ui-white>\r\n<div class=\"html-block__row\">\r\n<div class=\"html-block__column\">\r\n<div class=\"html-block__container html-block__container_size_small\">\r\n<div class=\"html-block__title\">Now in Stores</div>\r\n<div class=\"html-block__text\">\r\n<p>Discover where to purchase your new Hisense TV.</p>\r\n</div>\r\n<a class=\"html-block__button\" href=\"#\">WHERE TO BUY</a>\r\n</div>\r\n</div>\r\n<div class=\"html-block__column\">\r\n<img src=\"/images/product/tv-2.png\">\r\n</div>\r\n</div>\r\n</div>" },
          { position: 16, hero_ui_black: nil, is_active: true, color: nil, bg_color: nil, name: 'Disclaimer', built_in_block: 'disclaimer', html: nil }
        ].each do |block|
          section_block = product.content_blocks.find_by(name: block[:name]) ||
                          product.content_blocks.new(name: block[:name])
          bg_image_file_name = block.delete(:bg_image_file_name)
          section_block.assign_attributes(block)
          unless bg_image_file_name.nil?
            bg_image_file = File.open("public/images/product/#{bg_image_file_name}")
            section_block.bg_image = bg_image_file
            bg_image_file.close
          end
          section_block.save!
        end
      end
    end

    puts 'Done.'
  end
end
