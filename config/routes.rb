Rails.application.routes.draw do

  root to: 'welcome#index'

  resources :items, only: [:index, :show]

  resource :cart

  get '/login', to: 'sessions#new'

  get '/dashboard', to: 'users#show'

  resources :users, only: [:new, :create, :show]

  resources :categories, path: '/', only: [:show]

end
