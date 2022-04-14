Rails.application.routes.draw do

  resources :merchants do
    resources :dashboard, controller: 'merchant_dashboard', only: [:index]
    resources :items, controller: 'merchant_items'
    resources :invoices, controller: 'merchant_invoices', only: [:index]
  end

  get '/admin', to: 'admin#index'

  get '/admin/merchants', to: 'admin_merchants#index'
  get '/admin/merchants/:id', to: 'admin_merchants#show'
  get '/admin/merchants/:id/edit', to: 'admin_merchants#edit'

  get '/admin/invoices', to: 'admin_invoices#index'
  get '/admin/invoices/:id', to: 'admin_invoices#show'
end
