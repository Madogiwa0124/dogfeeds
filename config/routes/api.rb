# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :feeds, only: [:index, :show]
    resources :feed_entries, only: [:index], controller: 'feed/entries'
    resources :entries, only: [:index]
    resources :boards, only: [:create, :show, :index]
    resources :tags, only: [:index]
  end
end
