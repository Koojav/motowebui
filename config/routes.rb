Rails.application.routes.draw do

  resources :suites,    only: [:index] do
    resources :runs,    only: [:index, :show]  do
      resources :tests, only: [:show]
    end
  end

  get '/suites/:suite_id', to: redirect('/suites/%{suite_id}/runs')
  get '/suites/:suite_id/runs/:run_id/tests', to: redirect('/suites/%{suite_id}/runs/%{run_id}')


  # Friendly reminder 'resource' differs from 'resources'

  namespace :api do
    resources :suites,      defaults: {format: :json} do
      resource :batchtesters, defaults: {format: :json}, only: [:update]
      resources :runs,      defaults: {format: :json} do
        resource :batchresults, defaults: {format: :json}, only: [:update]
        resources :tests,   defaults: {format: :json} do
          resource :logs,   defaults: {format: :json}
        end
      end
    end

    resources :testers, defaults: {format: :json}
    resources :results, defaults: {format: :json}
  end

  root 'suites#index'
end
