Rails.application.routes.draw do
  # get '/merchants/:merchant_id/dashboard', to: 'dashboard#index'

  resources :merchants do 
    resources :items, :invoices
    resources :dashboard, only: [:index]
  end
end
