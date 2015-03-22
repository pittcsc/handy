Rails.application.routes.draw do
  root to: 'organizations#index'

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

  namespace :twilio do
    resources :text_messages
  end
  post 'text', to: 'twilio/text_messages#create'

  namespace :admin do
    mount Resque::Server, at: 'resque'
  end

  mount Easymon::Engine, at: 'monitoring/up'
end
