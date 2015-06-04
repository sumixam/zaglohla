require 'sidekiq/web'

Zaglohla::Application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  namespace :admin do
    resources :administrators
  end


  scope '/admin' do
    devise_for :administrators,
      controllers: {
        sessions: "admin/authentication/sessions"
      },
      path: ""
  end

  namespace :admin do
    resources :loader_ctos do
      collection do
        get :search
      end
      member do
        get :copy
      end
    end
    resources :repaires
    resources :photos
    resources :users
    resources :job_types
    resources :sub_job_types
    resources :services
    resources :car_brands
    resources :districts
    resources :metro_stations
    resources :cities
    resources :pages
    resources :manufacture_certs
    resources :repair_requests
    resources :repair_work_sectors
    resources :repair_work_types
    resources :repair_work_jobs
    resources :spare_queries
    resources :cto_responses
    resources :repaires do
      collection do
        post :calcs
      end
    end
    resources :spares do
      collection do
        post :upload
      end
    end
    resources :questions
    resources :answers
    resources :brands do
      collection do
        post :rmall
      end
    end
    resources :brand_brands
    resources :model_brands
    resources :generation_brands
    resources :engine_brands
    resources :cars
    root to: "home#index"
  end

  # Public pages
  %w(
    services terms
  ).each do |p|
    get "pages/#{p}" => "pages##{p}"
  end

  # authenticate :administrator do
  scope '/admin' do
    mount Sidekiq::Web => '/sidekiq'
  end
  # end
  mount Ckeditor::Engine => '/ckeditor'

  devise_for :users,
    controllers: {
      omniauth_callbacks: "authentication/omniauth_callbacks",
      registrations: "authentication/registrations",
      confirmations: "authentication/confirmations",
      passwords: "authentication/passwords",
      sessions: "authentication/sessions"
    }

  get '/ctos/brands/:brand_slug/locations/:location_slug', to: 'ctos#index'
  get '/ctos/brands/:brand_slug', to: 'ctos#index'
  get '/ctos/jobtypes/:job_slug', to: 'ctos#index'
  get '/ctos/locations/:location_slug', to: 'ctos#index'

  resources :profiles do
    member do
      post :thank
    end
  end
  resources :cars
  resources :car_brands
  resources :car_models
  resources :car_engines
  resources :car_generations
  resources :repair_work_types
  resources :repair_work_jobs
  resources :districts
  resources :metro_stations
  resources :questions do
    collection do
      post :search
    end
  end
  resources :cto_responses
  resources :invoices
  resources :answers
  resources :reports
  resources :repair_requests
  resources :ctos do
    collection do
      post :search
      get  :direct_search
    end
  end

  resources :estimations
  resources :spares do
    collection { post :search }
  end
  resources :wikis do
    collection { post :search }
  end
  root 'home#index'
end
