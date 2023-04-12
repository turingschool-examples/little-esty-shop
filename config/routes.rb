Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/admin', to: 'admin#dashboard', as: 'admin_dashboard'
  get 'admin/merchants', to: 'admin/merchants#index', as: 'admin_merchants'
  get 'admin/invoices', to: 'admin/invoices#index',  as: 'admin_invoices'
  get 'merchants/:id/dashboard', to: 'merchants#dashboard', as: 'merchant_dashboard'

  resources :admin, only: [:index]
  resources :merchants, only: [] do
    resources :items, except: [:create, :destroy], controller: 'merchants/items'
  end
end
