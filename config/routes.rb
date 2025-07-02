Rails.application.routes.draw do
  get 'events/index'
  get 'notices/new'
  get 'notices/create'
  get 'notices/done'
  get 'users/calendar', to: 'users#calendar', defaults: { format: 'json' }


  namespace :admin do
    get 'comments/index'
    get 'comments/destroy'
    get 'groups/index'
    get 'groups/show'
    get 'groups/destroy'
  end

  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }
  
  namespace :admin_panel do
    resources :groups, only: [:index, :destroy]
  end
  namespace :admin do
    get 'users/index'
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :comments, only: [:index, :destroy]
  end
  

  scope module: :public do
    devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
    resources :users, only: [:show, :index, :edit, :update, :destroy]
     collection do
      get 'calendar', to: 'users#calendar', defaults: { format: 'json' }
     end
    end

    root to: 'homes#top'
    get "/home/about" => "homes#about", as: "about"
    get '/search', to: 'searches#search'

    resources :images, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resources :post_comments, only: [:create, :destroy]
    end

    resources :events, only: [:index]
    
    resources :groups do
      resource :group_users, only: [:create, :destroy]
      resources :notices, only: [:new, :create]
      get "notices" => "notices#sent"
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
