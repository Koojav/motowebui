Rails.application.routes.draw do

  resources :directories, only: [:show]
  resources :tests, only: [:show]

  get '/directories', to: redirect('/directories/0')
  get '/', to: redirect('/directories/0')

  namespace :api do
    resources :directories, defaults: {format: :json}
    resources :tests,       defaults: {format: :json}
    resources :logs,        defaults: {format: :json}
    resources :testers,     defaults: {format: :json}
    resources :results,     defaults: {format: :json}
  end

end
