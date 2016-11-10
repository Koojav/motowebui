Rails.application.routes.draw do

  resources :suites, only: [:index, :show] do
    resources :runs, only: [:index, :show]  do
      resources :tests, only: [:index, :show]
    end
  end

  namespace :api do
    resources :suites,      controller: :suites,  defaults: {format: :json} do
      resources :runs,      controller: :runs,    defaults: {format: :json} do
        get 'evaluate_result', to: :evaluate_result
        resources :tests,   controller: :tests,   defaults: {format: :json}
      end
    end
  end

  root 'suites#index'
end
