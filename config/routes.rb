Rails.application.routes.draw do

  #-------Merchant-------------------
  resources :merchants do
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
    resources :merchants do
      member do
        patch :update_merchant_status, as: 'status_update'
      end
    end
  end

  scope module: 'admin' do
    resources :dashboard, path: 'admin'
  end
end
