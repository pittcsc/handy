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
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  post 'logout', to: 'sessions#destroy'

  namespace :twilio do
    resources :text_messages
  end
end
