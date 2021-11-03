Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'


  get '/admin', to: 'admins#dashboard'

  get '/admin/merchants', to: 'admin_merchants#index'
  get '/admin/merchants/:merchant_id', to: 'admin_merchants#show'


  resources :merchants, only: :index do
    resources :dashboard, only: [:index]
    resources :items, only: [:index, :show], controller: :merchant_items
    resources :invoices, only: [:index, :show], controller: :merchant_invoices

  end

end
