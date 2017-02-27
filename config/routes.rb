Rails.application.routes.draw do
  root to: 'pages#root'

  namespace :api do
    namespace :v1 do
      resources :states
      resources :elections, only: [:create, :update, :show, :destroy]
      resources :measures,  only: [:create, :update, :show, :destroy]
      resources :comments,  only: [:create, :update, :show, :destroy]

      resources :users

      post 'user_token' => 'v1/user_token#create'
    end
  end
end
