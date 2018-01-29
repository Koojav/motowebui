Rails.application.routes.draw do

  resources :directories, only: [:show] do
    resources :tests, only: [:show]
    resource :report, only: [:show]
  end


  get '/directories', to: redirect('/directories/0')
  get '/', to: redirect('/directories/0')
  get '/api/directories/:id/sub', controller: 'api/directories', to: 'api/directories#index'

  namespace :api do
    resources :directories,     only: [:create, :show, :update, :destroy],           defaults: {format: :json} do
      resources :tests,         only: [:index, :create, :show, :destroy],   defaults: {format: :json}
      resource :batchresults,  only: [:update],   defaults: {format: :json}
    end

    resource :motoresults,  only: [:create], defaults: {format: :json}

    resources :logs,        defaults: {format: :json}
    resources :testers,     defaults: {format: :json}
    resources :results,     defaults: {format: :json}
  end

end
