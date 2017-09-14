Rails.application.routes.draw do

  root to: 'welcome#index'

  resources :items, only: [:index]

  resource :cart

  get '/login', to: 'sessions#new'

  resources :categories, path: '/', only: [:show]

end
