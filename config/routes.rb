Rails.application.routes.draw do

	resources :items, only: [:index]

	resources :carts, only: [:create]

	resources :categories, path: "/", only: [:show]

	get '/cart', to: 'carts#index', as: 'cart'

end
