Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :merchants do
    resources :dashboard, only: :index
    resources :items
    resources :invoices, only: [:index, :show]
    resources :invoice_items, only: [:update]
  end

  get '/admin', to: 'admin#index'

  namespace :admin do
    resources :merchants
    resources :invoices
  end
end
