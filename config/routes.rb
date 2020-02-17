Rails.application.routes.draw do
  root to: 'categories#index'
  #resources :categories, only: [:show]
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, except: [:index, :show, :destroy]
  
  get 'search', to: 'topics#search'
  resources :topics
  
  resources :comments, except: [:index, :show]
end
