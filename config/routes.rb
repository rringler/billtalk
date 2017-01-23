Rails.application.routes.draw do
  resources :states
  constraints subdomain: 'api' do
    namespace :v1 do
      resources :states
      resources :elections, only: [:create, :update, :show, :destroy]
      resources :measures,  only: [:create, :update, :show, :destroy]
    end
  end
end
