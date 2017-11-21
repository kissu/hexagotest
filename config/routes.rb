Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  root 'pages#home'
  get 'dashboard', to: 'requests#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :users, only: [:new, :create] do
    member do
      get 'confirm'
      get 'refresh'
    end
  end

  resources :requests, only: [:index, :show, :edit, :update]
end
