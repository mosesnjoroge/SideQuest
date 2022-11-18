Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :sidequests do
    resources :reviews
  end
  resources :trips
end
