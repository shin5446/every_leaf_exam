Rails.application.routes.draw do
  namespace :admin do
    resources :users
  end

  get '/', to: 'top_pages#index'
  resources :tasks do
    collection do
      post :confirm
    end
  end

  resources :sessions, only: [:new, :create, :destroy]
  resources :users,except: [:index]
end
