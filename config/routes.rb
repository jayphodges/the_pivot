Rails.application.routes.draw do

  root to: 'welcome#index'

  resources :items, only: [:index, :show]

  resource :cart

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create' 
  delete '/logout', to: 'sessions#destroy'

  resources :orders, only: [:index, :show, :create, :update]

  namespace :admin do
    get '/dashboard', to: 'admin#show'
    resources :stores, only: [:index, :update]
    resources :items, only: [:new, :create, :index, :edit, :update]
  end

  get '/dashboard', to: 'users#show'

  resources :users, only: [:new, :create, :show, :update, :edit]

  get '/admin/reports', to: 'admin/reports#index', as: 'admin_reports'
  get '/password-reset', to: 'passwords#new', as: 'new_password_reset'
  post '/password-reset', to: 'passwords#create', as: 'password_reset'
  get '/password-confirmation', to: 'confirmations#new', as: 'new_password'
  post 'password-confirmation', to: 'passwords#update', as: 'update_password'
  # get '/category/:category_name', path: '/category', to: 'categories#show'
  resources :categories, path: '/category', only: [:show]
  get '/:store_name', params: :store_name, to: 'stores#show', as: 'store'
  get '/:store_name/edit', params: :store_name, to: 'stores#edit'
  patch '/:store_name', params: :store_name, to: 'stores#update'
  patch '/:store_name/orders', params: :store_name, to: 'stores/orders#update'

  namespace :stores, as: :store, path: ":store_name" do
    resources :orders, only: [:index]
    resources :admins, only: [:index]
    get '/admin/items', to: 'items#index'
    get '/admins/items/new', to: 'items#new'
    post '/admins/items/new', to: 'items#create'
  end


  resources :stores, path: "stores", only: [:index]

  get '/auth/twitter', as: 'twitter_login'
  get '/auth/twitter/callback', to: 'sessions#oauth_login'
  # get '/:store_name', param: :slug, to: 'stores#show'
  # resources :stores, only: [:index]

  namespace :api do
    namespace :v1 do
      get '/most_active_customers', to: 'most_active_customer#index'
      get '/most_expensive_orders', to: 'most_expensive_orders#index'
      get '/most_sold_items', to: 'most_sold_items#index'
      get '/top_selling_items', to: 'top_selling_items#index'
      get '/top_selling_stores', to: 'top_selling_stores#index'
    end
  end
end
