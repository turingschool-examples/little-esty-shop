Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/welcome', to: 'welcome#index'

  namespace :admin do
    get '/', to: 'dashboard#index'
    resources :merchants
    resources :invoices
  end

  get '/merchants/:id/dashboard', to: 'merchants#show'


end
