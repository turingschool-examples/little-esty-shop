Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/merchants/:id/dashboard', to: 'merchants#show'
  get '/merchants/:id/items', to: 'merchants#item_index'
  get '/merchants/:id/invoices', to: 'merchants#invoice_index'
end
