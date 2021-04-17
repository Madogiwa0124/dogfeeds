Rails.application.routes.draw do
  get '/', to: 'boards#new'
  resources :feeds, only: [:index, :show, :new, :create]
  resources :boards, only: [:show, :new, :index], constraints: { format: :html }
  get '/boards/:id', to: 'rss/boards#show', constraints: lambda { |req| req.format == :rss }
  get '/mypage', to: 'mypage#show'

  namespace :api do
    resources :feeds, only: [:index, :show]
    resources :feed_entries, only: [:index], controller: 'feed/entries'
    resources :entries, only: [:index]
    resources :boards, only: [:create, :show, :index]
    resources :tags, only: [:index]
  end

  namespace :admin do
    resources :boards
    resources :board_feeds
    resources :feeds
    require 'sidekiq/web'
    mount Sidekiq::Web, at: '/sidekiq'
  end
end
