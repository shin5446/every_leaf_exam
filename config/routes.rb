Rails.application.routes.draw do
  get '/', to: 'tasks#index'
  resources :tasks do
    collection do
      post :confirm
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
end
