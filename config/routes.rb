Rails.application.routes.draw do
  namespace :api do   
    namespace :v1 do
      resources :doctors, only: [:index]
      # resources :users
      post 'users/new_session', to: 'users#new_session'
    end
  end
end
