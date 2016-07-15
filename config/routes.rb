Rails.application.routes.draw do
  resources :sessions, only: [:new, :create]
  resources :users do
    resources :messages
  end

  get 'register' => 'users#new'
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'

  root 'pages#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
