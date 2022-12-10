Rails.application.routes.draw do
  get 'locations/index'
  devise_for :users
  root to: "pages#home"


  resources :trips do
  resources :side_quests do
    resources :reviews, only: %i[index new create]
    resources :stops
end
end

  resources :locations, only: [:new, :create]
end
