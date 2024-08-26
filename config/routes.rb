Rails.application.routes.draw do
  devise_for :users

  resources :posts, only: [:index, :new, :show]
  resources :users, only: [:index, :show]

  root "posts#index"
end
