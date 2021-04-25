# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'boards#new'
  resources :feeds, only: [:index, :show, :new, :create]
  resources :boards, only: [:show, :new, :index], constraints: { format: :html }
  get '/boards/:id', to: 'rss/boards#show', constraints: lambda { |req| req.format == :rss }
  get '/mypage', to: 'mypage#show'

  draw(:api)
  draw(:admin)
end
