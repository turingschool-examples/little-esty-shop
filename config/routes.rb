Rails.application.routes.draw do

  resources :merchants do
    resources :dashboard, controller: 'merchant_dashboard', only: [:index]
    resources :items, controller: 'merchant_items'
    resources :invoices, controller: 'merchant_invoices', only: [:index, :show]
  end

  get '/admin', to: 'admin#index'
  get '/admin/merchants', to: 'admin#merchants'
  get '/admin/invoices', to: 'admin#invoices'
  get '/admin/merchants/:id', to: 'admin#merchants_show'
  get '/admin/invoices/:id', to: 'admin#invoices_show'
end
