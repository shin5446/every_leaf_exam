Rails.application.routes.draw do
  get '/', to: 'tasks#index'
  resources :tasks do
    collection do
      post :confirm
    end
  end
end
