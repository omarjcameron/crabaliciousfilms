Rails.application.routes.draw do
  root 'categories#index'

  resources :users, only: [:index, :new, :show, :create]

  resources :sessions, only: [:new, :create, :destroy]

  resources :categories, only: [:index, :show]

  resources :films, except: [:index, :edit, :update]  do
    resources :reviews, only:  [:new, :create, :edit, :destroy]
    resources :ratings, only: [:new, :create, :edit, :destroy]
  end
end
