Rails.application.routes.draw do
  get '/', to: 'boards#new'
  resources :feeds, only: [:index, :show, :new, :create]
  resources :boards, only: [:show, :new, :index]

  namespace :api do
    resources :feeds, only: [:index, :show]
    resources :boards, only: [:create]
    resources :entries, only: [:index]
  end

  namespace :admin do
    resources :boards
    resources :board_feeds
    resources :feeds
  end
end
