Rails.application.routes.draw do

	resources :items, only: [:index]

	resources :carts, only: [:create]

	get '/cart', to: 'carts#index', as: 'cart'

	get '/:category_title', to: 'categories#show'
end
