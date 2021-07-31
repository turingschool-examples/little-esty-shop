Rails.application.routes.draw do
  resources :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get '/admin', to: 'admins#show'
  # get '/admin/merchants', to: 'admins#merchant_index'
  # get '/admin/invoices', to: 'admins#invoice_index'
  patch '/admin/merchants', to: 'admin/merchants#update_status', as: 'update_status'

  namespace :admin do #resources :admin, module: :admin do (namespace gives: scope, module and rake routes)
    resources only: [:index]
    resources :merchants
    resources :invoices
  end
end
