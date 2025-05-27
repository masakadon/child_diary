Rails.application.routes.draw do
  namespace :admin do
    get 'dashboard/index'
  end
  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  devise_for :admin_user, path: 'admin', skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    root to: "dashboard#index"
    get 'users/index'
    resources :users, only: [:index, :show, :edit, :update, :destroy]
  end
  

  scope module: :public do
    devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
    root to: 'homes#top'
    get "/home/about" => "homes#about", as: "about"
    get '/search', to: 'searches#search'
    resources :images, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resources :post_comments, only: [:create, :destroy]
    end
    resources :users, only: [:show, :index, :edit, :update, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
