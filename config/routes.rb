Rails.application.routes.draw do

  #-------Merchant-------------------
  resources :merchants do
    resources :invoices
    resources :items
  end
  #-------Admin----------------------
  namespace :admin do
    resources :invoices
    resources :merchants
  end
end
