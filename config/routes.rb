Rails.application.routes.draw do
  resources :lists do
    resources :tasks
  end
  devise_for :users
  get '/dashboard', to: 'dashboard#index'
  root to: 'root#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
