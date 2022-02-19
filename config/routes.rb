Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/merchant/:id/dashboard', to: 'merchants#show'
  get '/merchants/:id/items', to: 'merchant_items#index'
  get '/merchant/:id/invoices', to: 'merchant_invoices#index'

  get '/merchants/:id/items/:id', to: 'merchant_items#show'
end
