Rails.application.routes.draw do
  get '/', to: 'boards#new'
  resources :feeds
  resources :boards, only: [:show, :new, :index]

  namespace :api do
    resources :feeds, only: [:index]
    resources :boards, only: [:create]
  end
end
