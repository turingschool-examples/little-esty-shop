Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :merchants do
    resources :items, controller: 'merchant_items'
  end

  get '/merchants/:id/dashboard', to: 'merchants#dashboard'
  get '/merchants/:id/invoices', to: 'merchant_invoices#index'

  get 'admin/merchants', to: 'admin/merchants#index'
  get 'admin/merchants/:id', to: 'admin/merchants#show'
end
