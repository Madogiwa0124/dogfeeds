Rails.application.routes.draw do
  get '/', to: 'feeds#index'
  resources :feeds
  resources :boards, only: [:show, :index]

  namespace :api do
    resources :feeds, only: [:index]
    resources :boards, only: [:create]
  end
end
