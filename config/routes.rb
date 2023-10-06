Rails.application.routes.draw do
  mount Rswag::Ui::Engine => 'api/v1/api-docs'
  mount Rswag::Api::Engine => 'api/v1/api-docs'
  
  namespace :api do   
    namespace :v1 do
      root to: 'users#index', defaults: { format: :json }
      resources :doctors, only: [:index, :create , :destroy]
      # resources :users
      get 'doctors/main', to: 'doctors#three_first_doctors'
      resources :appointments, only: [:create]
      post 'appointments/find_all', to: 'appointments#find_all'
      post 'users/new_session', to: 'users#new_session'
    end
  end

 # root to: 'api/v1/users#index', defaults: { format: :json }
end
