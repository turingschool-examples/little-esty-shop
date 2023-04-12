Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/admin', to: 'admin#dashboard'
  get 'admin/merchants', to: 'admin/merchants#index'
  get 'admin/invoices', to: 'admin/invoices#index'

  resources :admin, only: [:index]
  resources :merchants, only: [] do
    resources :items, only: [:index, :show], controller: 'merchants/items'
  end
end
