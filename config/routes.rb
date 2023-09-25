Rails.application.routes.draw do
  namespace :api do
    resources :doctors, only: [:index]
    namespace :v1 do
      # resources :users
      post 'users/new_session', to: 'users#new_session'
    end
  end
end
