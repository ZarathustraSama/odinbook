Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :posts, only: [:index, :new, :show]
  resources :users, only: [:index, :show]

  root "posts#index"
end
