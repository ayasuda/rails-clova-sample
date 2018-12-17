Rails.application.routes.draw do
  use_doorkeeper
  post '/clova', to: 'clova#index'
  resources :lists do
    resources :tasks do
      patch 'complete', on: :member
      put 'complete', on: :member
    end
  end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  get '/dashboard', to: 'dashboard#index'
  root to: 'root#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
