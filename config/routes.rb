Rails.application.routes.draw do
  root to: 'events#index'

  post 'text', to: 'sms/inbound_messages#create'

  resources :events do
    member do
      post :activate
      post :deactivate
    end
  end

  resource :user

  # Authentication
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'

  namespace :admin do
    mount Resque::Server, at: 'resque'
  end

  get 'monitoring/up', to: 'monitoring#up'
  resource :boom
end
