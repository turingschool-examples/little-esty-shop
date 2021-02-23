Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :merchants, :invoices
  end

  resources :merchants do
    resources :invoices, :items, :dashboard
  end

  resources :customers, :invoice_items, :transactions
end
