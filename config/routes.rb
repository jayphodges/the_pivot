Rails.application.routes.draw do

	resources :items, only: [:index]
	resources :categories, path: "/", only: [:show]

end
