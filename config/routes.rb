Rails.application.routes.draw do
  resources :merchants, only: [:index, :create] do
    resources :items, only: [:index, :show, :edit, :update, :new, :create]
  end

  get '/', to: "welcome#index"

  get '/merchants/:merchant_id/invoices', to: 'merchant_invoices#index'
  get '/merchants/:merchant_id/invoices/:id', to: 'merchant_invoices#show'
  post '/merchants/:merchant_id/invoices/:id', to: 'merchant_invoices#update'
  get '/merchants/:merchant_id/dashboard', to: 'merchants#show'

  get '/admin/invoices', to: 'admin#index'
  get '/admin/invoices/:id', to: 'admin#show'
  patch '/admin/invoices/:id/update', to: 'admin#update'

  get '/admin/merchants', to: 'admin_merchants#index'
  get 'admin/merchants/:merchant_id', to: 'admin_merchants#show'
  get 'admin/merchants/:merchant_id/edit', to: 'admin_merchants#edit'
  patch 'admin/merchants/:merchant_id/update', to: 'admin_merchants#update'
  patch 'admin/merchants/:merchant_id/update-status', to: 'admin_merchants#update'
end
