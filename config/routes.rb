Rails.application.routes.draw do
  root "home#index"
  get 'logout', to: 'sessions#destroy'
  get '/auth/:provider/callback', to: 'authentications#callback'
  post '/channels/:id/settings', to: 'channels#settings'
  get '/channels/:id/settings', to: 'channels#show'
  get '/channels/:id/logs', to: 'error_logs#index'
  post '/channels/:id/logs/:error_id/ignore', to: 'error_logs#ignore'
  post '/channels/:id/logs/:error_id/retry', to: 'error_logs#retry'
  get '/auth/:provider/setup', to: 'sessions#setup'

  resources :channels, only: [:edit, :update]
end
