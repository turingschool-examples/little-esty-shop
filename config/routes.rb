Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'merchants/:id/dashboard', to: 'merchants#show'
  get 'merchants/:id/items', to: 'items#index'
  get 'merchants/:id/invoices', to: 'invoices#index'
  get 'merchants/:id/invoices/:id', to: 'invoices#show'
  get "merchants/:id/items/:id", to: "items#show"
  patch 'merchants/:id/items', to: 'items#update'

end
