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

  # get '/category/:category_name', path: '/category', to: 'categories#show'
  resources :categories, path: '/category', only: [:show]
  get '/:store_name', params: :store_name, to: 'stores#show'

  namespace :stores, as: :store, path: ":store_name" do
    resources :orders, only: [:index]
    resources :admins, only: [:index]
    get '/admin/items', to: 'items#index'
  end


  resources :stores, path: "stores", only: [:index]

  get '/auth/twitter', as: 'twitter_login'
  get '/auth/twitter/callback', to: 'sessions#oauth_login'
  # get '/:store_name', param: :slug, to: 'stores#show'
  # resources :stores, only: [:index]
end
