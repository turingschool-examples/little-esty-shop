Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/' ,to: "welcome#index"

  resources :merchants, only:[:show] do
    resources :items, except:[:destroy]
    resources :invoices, only:[:index, :show]
    resources :dashboard, only:[:index]
  end

  resources :admin, controller: 'admin/dashboard', only: [:index]
  # namespace :admin do
  #   # resources :invoices
  #   # resources :merchants
  # end

  get '/admin/invoices', to: 'admin/invoices#index'
  get '/admin/invoices/:id', to: 'admin/invoices#show'

  get '/merchants/:id/invoices', to: 'merchant_invoices#index'

  post '/merchants/:merchant_id/invoice_items', to: 'invoice_items#update'
  get '/admin/merchants/:id/dashboard', to: "admin/dashboard#index"

  get '/admin', to: "admin/dashboard#index"
  get '/admin/merchants', to: 'admin/merchants#index'
  get '/admin/merchants/:id', to: 'admin/merchants#show'
  get '/admin/merchants/:id/edit', to: 'admin/merchants#edit'
  patch '/admin/merchants/:id', to: 'admin/merchants#update'

  # get '/merchants/:id/invoices', to: 'merchant_invoices#index'
  get '/merchants/:merchant_id/invoices/:id', to: 'merchant_invoices#show'
end
