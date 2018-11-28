Rails.application.routes.draw do
  devise_for :users
  get '/dashboard', to: 'dashboard#index'
  get 'root/index'
  root to: 'root#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
