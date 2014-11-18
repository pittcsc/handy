Rails.application.routes.draw do
  root to: 'events#index'

  post 'text', to: 'sms/inbound_messages#create'

  resources :events do
    member do
      post :make_current
      post :remove_current
    end

    resources :attendances
  end

  # Resources for user creation and such
  resources :users

  # Login/logout information
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
end
