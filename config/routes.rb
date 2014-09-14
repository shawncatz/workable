Workable::Engine.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/queue'

  resources :workers
end
