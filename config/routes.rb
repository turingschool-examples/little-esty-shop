Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/admin', to: 'admin#dashboard', as: 'admin_dashboard'
  get 'admin/merchants', to: 'admin/merchants#index', as: 'admin_merchants'
  get 'admin/invoices', to: 'admin/invoices#index',  as: 'admin_invoices'
  get 'merchants/:id/dashboard', to: 'merchants#dashboard', as: 'merchant_dashboard'

  namespace :admin do
    resources :merchants, only: [:index, :show]
  end
  resources :merchants, only: [] do
    resources :items, except: [:destroy], controller: 'merchants/items'
    resources :invoices, only: [:index, :show], controller: 'merchants/invoices'
  end
end
