require 'sidekiq/web'

Rails.application.routes.draw do
  get '/admin', to: redirect('/admin/products'), as: 'admin_root'
  get '/admin/login', to: redirect('/login'), as: 'login'
  get '/cuse/cedoc', to: redirect('/downloads')
  get '/products', to: redirect('/')
  get '/404', to: 'spree/error#not_found'

  mount Redactor2Rails::Engine => '/redactor2_rails'
  Spree::Core::Engine.add_routes do
    get '/robots.txt', to: 'home#robots'
    get 'company', to: 'company#index'
    get 'downloads', to: 'downloads#index'
    get 'regional-websites', to: 'regional_websites#index'
    get 'knowledge-center', to: 'knowledge_centers#show'
    get 'search', to: 'search#index'
    get 'where-to-buy', to: 'where_to_buy#index', as: 'where_to_buy'

    resources :careers, only: :index
    resource :sitemap, only: :show
    resource :subscribers, only: :create
    resource :support, only: :show do
      get ':model_number', to: 'supports#show'
    end
    resources :news, only: %i[index show]
    resources :sponsorships, only: %i[index show] do
      member do
        resources :news, only: %i[index], as: 'sponsorship_news'
      end
    end
    resources :contact, only: %i[index create]
    resources :register_product, only: %i[index create]

    get '/:id',
        to: 'legal_pages#show', as: :legal_page,
        constraints: lambda { |request|
          Spree::LegalPage.where(slug: request.params['id']).exists?
        }
    get '/*id',
        to: 'taxons#show',
        constraints: lambda { |request|
          Spree::Taxon.friendly.exists?(permalink: request.params['id'])
        }


    namespace :admin do
      # Products
      resources :products do
        resources :content_blocks do
          collection do
            post :update_positions
          end
        end
      end
      resources :property_value_icons do
        collection do
          post :update_positions
        end
      end

      # Home
      resources :hero_slides do
        collection do
          post :update_positions
        end
      end
      resources :company_blocks do
        collection do
          post :update_sections_positions
        end
      end
      resources :company_block_sections
      resources :taxons do
        collection do
          post :update_left_menu_items_positions
          post :update_right_menu_items_positions
        end
      end
      resources :taxons_left_menu_items
      resources :taxons_right_menu_items

      resources :left_menu_items do
        collection do
          post :update_positions
        end
      end
      resources :right_menu_items do
        collection do
          post :update_positions
        end
      end

      resources :files

      resources :news
      resources :image_files, only: :create

      # Pages
      resources :company_pages do
        collection do
          post :update_positions
        end
      end
      resources :careers do
        collection do
          post :update_positions
        end
      end
      resources :sponsorships do
        collection do
          post :update_positions
        end
      end

      resources :contact_contents

      # Configuration
      resource :general_settings do
        collection do
          post :clear_cache
        end
      end
      resources :menu_items do
        collection do
          post :update_positions
        end
      end
      resources :news_categories do
        collection do
          post :update_positions
        end
      end
      resources :downloads_categories do
        collection do
          post :update_positions
        end
      end
      resources :questions_categories do
        collection do
          post :update_positions
        end
      end
      resources :popular_searches do
        collection do
          post :update_positions
        end
      end
      resources :footer_items do
        collection do
          post :update_positions
        end
      end
      resources :questions do
        collection do
          post :update_positions
        end
      end
      resources :legal_pages do
        collection do
          post :update_positions
        end
      end
      resources :countries do
        collection do
          post :update_positions
        end
      end
      resources :contacts do
        collection do
          post :update_positions
        end
      end
      resources :subscribers do
        collection do
          get :download
        end
      end
      resources :online_stores do
        collection do
          post :update_positions
        end
      end
      resources :offline_stores

      resources :messages do
        collection do
          get :download
        end
      end
      resources :downloads
    end
  end

  mount Sidekiq::Web, at: '/admin/sidekiq'
  mount Spree::Core::Engine, at: '/'
end
