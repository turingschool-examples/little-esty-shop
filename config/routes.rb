Rails.application.routes.draw do
  namespace :admin do
    resources :merchants
    resources :invoices
    get 'dashboard', to:'dashboard#index'
  end
  resources :merchants do
    resources :items, controller: 'merchant/items'
    resources :invoices, controller: 'merchant/invoices'
    get 'dashboard', to:'merchant/dashboard#show', on: :member
  end
end
