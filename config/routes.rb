Rails.application.routes.draw do

  #-------Merchant-------------------
  resources :merchants do
    resources :invoice_items
    resources :invoices
    resources :items do
      member do
        patch 'update_item_status', as: 'status_update'
      end
    end
  end
  #-------Admin----------------------
  namespace :admin do
    resources :invoices
    resources :merchants
  end
end
