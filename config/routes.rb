Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      resources :appointments, only: [:create]
      post 'appointments/find_all', to: 'appointments#find_all'
      post 'users/new_session', to: 'users#new_session'
    end
  end
end
