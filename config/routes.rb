Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :merchants do
    resources :dashboard, only: [:index]
    get '/items', to: 'merchant_items#index'
    get '/items/new', to: 'merchant_items#new'
    post '/items', to: 'merchant_items#create'
    get '/items/:id', to: 'merchant_items#show'
    get '/items/:id/edit', to: 'merchant_items#edit'
    patch 'items/:id', to: 'merchant_items#update'

    get '/invoices', to: 'merchant_invoices#index'
    get '/invoices/:invoice_id', to: 'merchant_invoices#show'
    patch '/invoices/:invoice_id', to: 'merchant_invoices#update'
  end

  namespace :admin do
    root to: 'admin#index'
    resources :merchants, only: [:index, :new, :show, :create, :edit, :update]
    resources :invoices, only: [:index, :show, :update]
  end
end
