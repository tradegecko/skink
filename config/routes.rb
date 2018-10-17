Rails.application.routes.draw do
  root "home#index"
  get 'logout', to: 'sessions#destroy'
  get '/auth/:provider/callback', to: 'authentications#callback'
  post '/channels/:id/settings', to: 'channels#settings'
  get '/channels/:id/settings', to: 'channels#show'
  get '/channels/:id/logs', to: 'error_logs#index'
  get '/channels/:id/logs/:error_id/ignore', to: 'error_logs#ignore'
  get '/channels/:id/logs/:error_id/retry', to: 'error_logs#retry'
end
