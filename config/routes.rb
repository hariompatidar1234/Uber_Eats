Rails.application.routes.draw do
  # devise_for :admin_users, ActiveAdmin::Devise.config
  # ActiveAdmin.routes(self)

  devise_for :users
  root to: "restaurants#index"


  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end

   resource :profile, controller: 'users', as: 'current_user_profile'

  resources :categories

  resources :restaurants  do
    get 'my_restaurants_list', on: :collection
  end

  # resources :restaurants
   resources :carts

  resources :dishes do
    collection do
      get 'owner_dishes'
      get 'filter', action: :index
    end
  end

  resources :orders
end
