Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'merchants/:id/items', to: 'items#index'
  get 'merchants/:id/items/:item_id', to: 'items#show'
  get 'merchants/:id/invoices', to: 'invoice_items#index'
end
