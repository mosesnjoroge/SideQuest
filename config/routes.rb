Rails.application.routes.draw do
  get 'locations/index'
  devise_for :users
  root to: "pages#home"

  resources :trips do
    resources :side_quests, except: %i[new] do
      resources :reviews, only: %i[index new create]
      resources :stops
    end
  end
  resources :side_quests, only: %i[new create]
  resources :locations, only: %i[new create]
end
