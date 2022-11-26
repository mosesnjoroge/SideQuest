Rails.application.routes.draw do
  get 'locations/index'
  devise_for :users
  root to: "pages#home"

  resources :side_quests do
    resources :reviews, only: [:new, :create]
  end
  resources :trips
  resources :locations, only: [:new, :create]
end
