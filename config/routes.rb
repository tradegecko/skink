Rails.application.routes.draw do
  root "home#index"
  get 'logout', to: 'sessions#destroy'
  get '/auth/:provider/callback', to: 'authentications#callback'
  post '/channels/:id/settings', to: 'channels#settings'
  get '/channels/:id/settings', to: 'channels#show'
end
