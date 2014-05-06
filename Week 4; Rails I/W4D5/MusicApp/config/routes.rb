MusicApp::Application.routes.draw do

  resource :session, only: [:new, :create, :destroy]

  resources :users, only: [:new, :create, :show]

  resources :bands do
    resources :albums, only: [:index, :new, :create]
  end

  resources :albums, only: [:edit, :update, :show, :destroy] do
    resources :tracks, only: [:index, :new, :create]
  end

  resources :tracks, only: [:edit, :update, :show, :destroy]

  root to: "users#show"
end
