Rails.application.routes.draw do
  namespace :admin do
    resources :users
  end

  get '/', to: 'tasks#index'
  resources :tasks do
    collection do
      post :confirm
    end
  end

  resources :sessions, only: [:new, :create, :destroy]
  resources :users,except: [:index]
end
