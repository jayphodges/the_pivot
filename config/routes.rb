Rails.application.routes.draw do

  root to: 'welcome#index'

  resources :items, only: [:index, :show]

  resource :cart

  resources :categories, path: '/', only: [:show]

end
