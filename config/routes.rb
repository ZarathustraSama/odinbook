Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :users, only: [:index, :show]
  resources :follows, only: [:index, :create, :update, :destroy]
  resources :posts, only: [:index, :new, :create, :show]
  resources :likes, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]

  root "posts#index"
end
