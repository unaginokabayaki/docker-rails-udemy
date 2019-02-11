Rails.application.routes.draw do
  
  root 'home#index'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'mypage', to: 'users#me'
  resources :users, only: %i[new create]
  
  # get 'comments/create'
  # get 'comments/destroy'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'boards#index'
  resources :boards
  resources :comments, only: %i[create destroy]
  # resources :boards, only: [:index, :new, :create, :show, :edit, :update]
  # get 'boards', to: 'boards#index'
  # get 'boards/new', to: 'boards#new'
  # post 'boards', to: 'boards#create'
  # get 'boards/:id', to: 'boards#show'

end
