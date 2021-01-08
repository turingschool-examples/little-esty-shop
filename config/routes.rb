Rails.application.routes.draw do
  namespace :admin do
    resources :merchants, except: [:destoy]
    resources :invoices, only: [:index, :show, :update]
  end

  resources :merchants do
    resources :items
    resources :invoices
    resources :invoice_items, only: [:update]
    resources :dashboard, only: [:index]
  end

  resources :admin, controller: 'admin/dashboard', only: [:index]
end
