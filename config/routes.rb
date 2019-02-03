Rails.application.routes.draw do
  get '/', to: 'feeds#index'
  resources :feeds
end
