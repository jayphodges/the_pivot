Rails.application.routes.draw do

	resources :items, only: [:index]

	resources :carts

	resources :categories, path: "/", only: [:show]

end
