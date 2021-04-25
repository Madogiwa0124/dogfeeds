# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    root to: 'boards#index'
    resources :boards
    resources :board_feeds
    resources :feeds
    require 'sidekiq/web'
    mount Sidekiq::Web, at: '/sidekiq'
  end
end
