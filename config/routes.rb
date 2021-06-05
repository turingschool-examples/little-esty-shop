Rails.application.routes.draw do

  #-------Merchant-------------------
  resources :merchants do
    resources :invoices
    resources :items do
      member do
        :update_item_status
      end
    end
  end
  #-------Admin----------------------
  namespace :admin do
    resources :invoices
    resources :merchants
  end
end
