Rails.application.routes.draw do
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  # devise_for :admin, skip: [:registrations, :passwords] controllers: {
  #   sessions: 'admin/sessions'
  # }

  root to: 'homes#top'

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }

  resources :images, only: [:new, :index, :show]
  resources :users, only: [:show, :index, :edit, :update]
  get "/home/about" => "homes#about", as: "about"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
