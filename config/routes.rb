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
end
