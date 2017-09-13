Rails.application.routes.draw do

  resources :items, oonly: [:index]

  resources :carts, only: [:create]

  get '/cart', to: 'carts#index', as: 'cart'

  resources :categories, path: '/', only: [:show]

end
