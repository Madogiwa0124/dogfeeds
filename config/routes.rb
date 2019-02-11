Rails.application.routes.draw do
  get '/', to: 'feeds#index'
  resources :feeds

  namespace :api do
    resources :feeds, only: [:index]
  end
end
