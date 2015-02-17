Rails.application.routes.draw do
  constraints subdomain: 'api' do
    namespace :api, path: '/' do
      resources :zombies
    end
  end
end
