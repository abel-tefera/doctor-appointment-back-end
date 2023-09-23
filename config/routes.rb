Rails.application.routes.draw do
  namespace :api do
    resources :doctors, only: [:index, :create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      # resources :users
      post 'users/new_session', to: 'users#new_session'
    end
  end
end
