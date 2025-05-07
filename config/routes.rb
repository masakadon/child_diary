Rails.application.routes.draw do
  namespace :admin do
    get 'users/index'
  end
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }
  
  devise_for :users, controllers: {
    registrations: "user/registrations",
    sessions: 'users/sessions'
  }

  root to: 'homes#top'
  get "/home/about" => "homes#about", as: "about"
  get '/search', to: 'searches#search'

  resources :images, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resources :post_comments, only: [:create, :destroy]
  end
  resources :users, only: [:show, :index, :edit, :update, :destroy]

  namespace :admin do
    resource :users, only: [:index, :show, :edit, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
