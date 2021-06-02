Rails.application.routes.draw do

#-------Merchant-------------------
  resources :merchants do
    resources :invoices
  end
#-------Admin----------------------
  namespace :admin do
    resources :merchants do
      member do
        post :update_status
      end
    end
  end
end
