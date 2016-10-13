Rails.application.routes.draw do

  resources :test_suites do
    resources :test_runs do
      resources :tests
    end
  end

  namespace :api do
    resources :test_suites, controller: :test_suites, defaults: {format: :json} do
      resources :test_runs, controller: :test_runs,   defaults: {format: :json} do
        resources :tests,   controller: :tests,       defaults: {format: :json}
      end
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
