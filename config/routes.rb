Rails.application.routes.draw do
  
  resources :merchants do
    get '/dashboard', to: 'merchants#dashboard'
    resources :items
    resources :invoices
  end

  resources :transactions
  resources :customers
end
