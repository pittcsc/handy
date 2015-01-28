Rails.application.routes.draw do
  root to: 'organizations#index'

  post 'text', to: 'sms/inbound_messages#create'

  resources :organizations do
    # Showing an organization is displaying its events
    get '', to: 'events#index'

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
  get 'logout' => 'sessions#destroy'

  namespace :admin do
    mount Resque::Server, at: 'resque'
  end

  get 'monitoring/up', to: 'monitoring#up'
  resource :boom
end
