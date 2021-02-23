Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :customers, :merchants, :invoice_items, :invoices, :transactions, :items

  namespace :admin do
    resources :merchants, :invoices
  end
end
