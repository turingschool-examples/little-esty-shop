Rails.application.routes.draw do
  namespace :admin do
    resources :merchants
    resources :invoices
  end
  
  resources :merchants do
    resources :items
    resources :invoices
  end

  resources :admin, controller: 'admin/dashboard', only: [:index]
end
