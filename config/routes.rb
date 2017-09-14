Rails.application.routes.draw do

  resources :items, only: [:index]

  # resources :carts, only: [:create]

  # get '/cart', to: 'carts#show', as: 'cart'
  resource :cart

  resources :categories, path: '/', only: [:show]

  get '/', to: 'root#index'
end
