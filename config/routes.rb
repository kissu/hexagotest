Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  mount Sidekiq::Web => '/sidekiq'

  root 'pages#home'

  resources :users, only: [:new, :create] do
    member do
      get 'confirm'
      get 'refresh'
    end
  end

  get 'requests/thanks', to: 'requests#thanks'
  resources :requests, only: [:index, :show, :edit, :update]
end
