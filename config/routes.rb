Rails.application.routes.draw do
  get '/', to: 'boards#new'
  resources :feeds, only: [:index, :show, :new, :create]
  resources :boards, only: [:show, :new, :index], constraints: { format: :html }
  get '/boards/:id', to: 'rss/boards#show', constraints: lambda { |req| req.format == :rss }

  namespace :api do
    resources :feeds, only: [:index, :show]
    resources :boards, only: [:create, :show]
    resources :entries, only: [:index]
  end

  namespace :admin do
    resources :boards
    resources :board_feeds
    resources :feeds
  end
end
