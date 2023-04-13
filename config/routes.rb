Rails.application.routes.draw do
  namespace :admin do
    resources :merchants
    get 'dashboard', to:'dashboard#show'
  end
  resources :merchants do
    resources :items, controller: 'merchant/items'
    resources :invoices, controller: 'merchant/invoices'
    get 'dashboard', to:'merchant/dashboard#show', on: :member
  end
end
