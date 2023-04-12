Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'application#welcome'
  get '/merchants', to: 'merchants#index'

  get '/admin', to: 'admin#index'

  namespace :admin do
    resources :merchants, except: [:destroy, :create , :update]
    resources :invoices, only: [:index, :show]
  end
  
  get '/merchants/:id/dashboard', to: 'merchants#show'
end
