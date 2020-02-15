Rails.application.routes.draw do
  root to: 'categories#index'
  
  get 'signup', to: 'users#new'
  resources :users, except: [:index, :destroy]
end
