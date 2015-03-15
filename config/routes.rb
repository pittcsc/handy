Rails.application.routes.draw do
  root to: 'organizations#index'

  post 'text', to: 'sms/inbound_messages#create'

  resources :organizations do
    resources :events do
      member do
        post :activate
        post :deactivate
      end
    end
  end

  resource :user

  # Authentication
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  post 'logout' => 'sessions#destroy'

  namespace :admin do
    mount Resque::Server, at: 'resque'
  end

  mount Easymon::Engine, at: 'monitoring/up'
end
