Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'movies#index'

  resources :movies do
    resources :ratings, only: [:create]
  end

  resources :categories

  namespace :api, defaults: { format: :json } do
    resources :movies
  end
end
