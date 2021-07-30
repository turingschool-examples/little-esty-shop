Rails.application.routes.draw do

  get '/', to: 'welcome#index'


  resources :merchants, module: :merchant, only: [:show, :index]

  resources :merchants, module: :merchant, only: [:show, :index] do
      resources :items
      resources :invoices
      resources :dashboard, only: [:index]
      resources :invoice_items, only: [:update]
  end

  namespace :admin do
    resources only: [:index]
    resources :merchants
    resources :invoices
  end
end
