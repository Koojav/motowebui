Rails.application.routes.draw do

  resources :suites do
    resources :runs do
      resources :tests
    end
  end

  namespace :api do
    resources :suites,      controller: :suites,  defaults: {format: :json} do
      resources :runs,      controller: :runs,    defaults: {format: :json} do
        resources :tests,   controller: :tests,   defaults: {format: :json}
      end
    end
  end

  root 'boot#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
