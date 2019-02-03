Rails.application.routes.draw do
  # get 'comments/create'
  # get 'comments/destroy'
  root 'home#index'
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
