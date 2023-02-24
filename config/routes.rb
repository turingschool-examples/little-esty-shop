Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    get '/', to: 'dashboard#index'
    resources :invoices, only: [:show, :index]
    resources :merchants, only: [:index, :show, :new, :create]
  end

  get '/merchants/:merchant_id/dashboards', to: 'merchants#dashboards'
end
