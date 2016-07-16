Rails.application.routes.draw do
  resources :sessions, only: [:new, :create]
  resources :messages do
    collection do
      get :sent
      get :received
    end
  end

  resources :friendships, only: [:create, :destroy]
  resources :users do
    resources :messages
  end


  get 'register' => 'users#new'
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'

  get 'sent' => 'pages#sent'

  get 'friends' => 'pages#friends'

  root 'pages#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
