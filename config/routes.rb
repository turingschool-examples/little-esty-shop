Rails.application.routes.draw do
  root "welcome#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/merchants/:id/dashboard', to: 'merchants#show'
  get '/merchants/:id/items', to: 'merchants#item_index'
  get '/merchants/:id/items/new', to: 'merchants#new_item'
  get '/merchants/:id/invoices', to: 'merchants#invoice_index'
  get '/merchants/:merch_id/items/:item_id', to: 'merchants#item_show'
  get '/items/:id/edit', to: 'items#edit'
end
