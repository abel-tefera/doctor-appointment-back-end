Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # resources :users
      resources :doctors, only: [:index]
      post 'users/new_session', to: 'users#new_session'
    end
  end
end
