Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do   
    namespace :v1 do
      resources :doctors, only: [:index, :create , :destroy]
      # resources :users
      get 'doctors/main', to: 'doctors#three_first_doctors'
      resources :appointments, only: [:create]
      post 'appointments/find_all', to: 'appointments#find_all'
      post 'users/new_session', to: 'users#new_session'
    end
  end
end
