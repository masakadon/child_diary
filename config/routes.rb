Rails.application.routes.draw do
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  # devise_for :admin, skip: [:registrations, :passwords] controllers: {
  #   sessions: 'admin/sessions'
  # }

  devise_for :user, controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }

  root to: 'homes#top'
  get "/home/about" => "homes#about", as: "about"
  resources :images, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  resources :users, only: [:show, :index, :edit, :update, :destroy]
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
