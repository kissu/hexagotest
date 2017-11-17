Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'users#new'
  post 'users', to: 'users#create'
  get 'requests/thanks', to: 'requests#thanks'
  resources :requests, only: [:index, :show, :edit, :update]
end
