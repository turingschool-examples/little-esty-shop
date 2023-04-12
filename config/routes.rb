Rails.application.routes.draw do
  get '/merchants/:id/dashboard', to: 'merchants#show', as: 'merchant_dashboard'

  get '/admin', to: 'admin#show', as: 'admin_dashboard'
  
  resources :merchants, only: [] do
    resources :items, only: :index, controller: 'merchants/items'
  end

  resources :merchants, only: [] do
    resources :invoices, only: :index, controller: 'merchants/invoices'
  end
end
