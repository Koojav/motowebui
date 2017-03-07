Rails.application.routes.draw do

  resources :suites,    only: [:index] do
    resources :runs,    only: [:index, :show]  do
      resources :tests, only: [:show]
    end
  end

  get '/suites/:suite_id', to: redirect('/suites/%{suite_id}/runs')
  get '/suites/:suite_id/runs/:run_id/tests', to: redirect('/suites/%{suite_id}/runs/%{run_id}')

  namespace :api do
    resources :suites,      defaults: {format: :json} do
      resources :runs,      defaults: {format: :json} do
        resources :tests,   defaults: {format: :json} do
          # Friendly reminder 'resource' not 'resources' - singular resource
          resource :logs,   defaults: {format: :json}
        end
      end
    end

    resources :testers, defaults: {format: :json}
    resources :results, defaults: {format: :json}
  end

  root 'suites#index'
end
