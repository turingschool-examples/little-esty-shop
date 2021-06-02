Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :customers,
              :invoices,
              :merchants,
              :items,
              :invoice_items,
              :transactions
  end
end
