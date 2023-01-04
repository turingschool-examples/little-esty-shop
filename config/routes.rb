Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/merchants', to: 'merchants#index'
  get '/merchants/:id/dashboard', to: 'merchants#show'

  get '/admin', to: 'admin/dashboard#index'
  
  namespace :admin do
    resources :merchants, only: [:index, :show]

  end
end
