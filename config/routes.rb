Rails.application.routes.draw do
  resources :merchants do
    resources :items, controller: 'merchant_items'
  end
  get '/merchant/:id/dashboard', to: 'merchants#show'
  get '/merchant/:id/invoices', to: 'merchant_invoices#index'
end
