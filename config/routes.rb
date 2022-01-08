Rails.application.routes.draw do
  # get '/merchants/:merchant_id/dashboard', to: 'dashboard#index'
  namespace :admin do
    resources :merchants
  end
  
  resources :merchants do
    resources :items, :invoices
    resources :dashboard, only: [:index]
  end
end
