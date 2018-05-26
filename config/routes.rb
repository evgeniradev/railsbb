Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'sections#index'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    get 'profile/:id', to: 'users/registrations#show', as: :profile_user
    post 'disable', to: 'users/registrations#disable', as: :disable_user
  end
  resources :sections
  resources :forums
  resources :topics
  resources :posts
  namespace :admin do
    root to: 'settings#index', as: :root
    resources :settings
    resources :sections
    resources :forums
    devise_for :users
    devise_scope :users do
      root to: '/admin/users#index'
      resources :users
    end
  end
  # Static Pages
  get 'terms-and-conditions', to: 'static_pages#terms_and_conditions'
end
