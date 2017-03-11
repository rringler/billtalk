Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :states
      resources :elections, only: [:create, :update, :show, :destroy]
      resources :measures,  only: [:create, :update, :show, :destroy]
      resources :comments,  only: [:create, :update, :show, :destroy]
      resources :users

      resource :session, only: [:create]
    end
  end

  root         to: 'pages#root'
  get '*path', to: 'pages#root'
end
