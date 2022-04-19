Rails.application.routes.draw do

  resources :merchants do
    resources :dashboard, controller: 'merchant_dashboard', only: [:index]
    resources :items, controller: 'merchant_items'
    resources :invoices, controller: 'merchant_invoices', only: [:index, :show, :update]
  end

  get '/admin', to: 'admin#index'

  get '/admin/merchants', to: 'admin_merchants#index'
  get '/admin/merchants/new', to: 'admin_merchants#new'
  get '/admin/merchants/:id', to: 'admin_merchants#show'
  get '/admin/merchants/:id/edit', to: 'admin_merchants#edit'
  patch '/admin/merchants/:id', to: 'admin_merchants#update'
  post '/admin/merchants/new', to: 'admin_merchants#create'

  get '/admin/invoices', to: 'admin_invoices#index'
  get '/admin/invoices/:id', to: 'admin_invoices#show'
  patch '/admin/invoices/:id', to: 'admin_invoices#update'

end
