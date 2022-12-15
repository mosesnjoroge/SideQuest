Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :trips do
    resources :side_quests do
      resources :reviews, only: %i[index new create]
      resources :stops
    end
  end
  resources :side_quests, only: %i[new create show]
end
