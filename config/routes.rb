Rails.application.routes.draw do
  resources :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/merchants/:id/dashboard', to: 'merchants#dashboard'
  get '/merchants/:id/dashboard/invoices/:invoice_id', to: 'merchant_invoices#show' #merchant/merchant_invoices#show'
  get '/merchants/:id/items', to: 'merchant_items#index' #merchant/merchant_items#index'
  get '/merchants/:id/invoices', to: 'merchant_invoices#index' #merchant/merchant_invoices#index'

  #namespace merchants do

  # end

  # get '/admin', to: 'admins#show'
  # get '/admin/merchants', to: 'admins#merchant_index'
  # get '/admin/invoices', to: 'admins#invoice_index'

  namespace :admin do #resources :admin, module: :admin do (namespace gives: scope, module and rake routes)
    resources only: [:index] 
    resources :merchants
    resources :invoices
  end
end
