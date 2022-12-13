Rails.application.routes.draw do
  devise_for :users
  
  authenticate :user do
    resources :users
    resources :friend_requests
    resources :friendships
    resources :notifications
  end

  # Defines the root path route ("/"), requring login if not logged in
  authenticated :user do
    root to: "users#index", as: :authenticated_root
  end
  root to: redirect("/users/sign_in")
end
