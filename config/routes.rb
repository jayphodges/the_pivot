Rails.application.routes.draw do

  root to: 'welcome#index'

  resources :items, only: [:index, :show]

  resource :cart

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :orders, only: [:index, :show, :create]

  namespace :admin do
    get '/dashboard', to: 'admin#show'
    resources :items, only: [:new, :create]
  end

  get '/dashboard', to: 'users#show'

  resources :users, only: [:new, :create, :show, :update, :edit]

  resources :categories, path: '/', only: [:show]

end
