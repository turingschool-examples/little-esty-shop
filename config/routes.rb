Rails.application.routes.draw do

  get '/', to: 'welcome#index'

  resources :merchants, except: [:show] do 
    resources :invoices
    resources :items
    resources :invoice_items
  end

  get '/merchants/:merchant_id/dashboard', to: 'merchants#show'

  resources :admin, only: [:index]

  namespace :admin do
    resources :merchants
    resources :invoices, only: [:index, :show, :update]
  end
end
