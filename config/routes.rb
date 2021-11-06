Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'


  get '/admin', to: 'admins#dashboard'

  get '/admin/merchants',                   to: 'admin_merchants#index'
  get '/admin/merchants/new',               to: 'admin_merchants#new'
  post '/admin/merchants',                  to: 'admin_merchants#create'
  patch '/admin/merchants/:merchant_id',    to: 'admin_merchants#update'
  get '/admin/merchants/:merchant_id/edit', to: 'admin_merchants#edit'
  get '/admin/merchants/:merchant_id',      to: 'admin_merchants#show'

  get '/admin/invoices',             to: 'admin_invoices#index'
  get '/admin/invoices/:invoice_id', to: 'admin_invoices#show'
  patch '/admin/invoices/:invoice_id', to: 'admin_invoices#update'

  # resources :admin, only: :index do
  #   resources :merchants, only: [:index, :new, :show, :create, :update, :edit]
  #   resources :invoices, only: [:index, :show]
  # end


  resources :merchants, only: :index do
    resources :dashboard, only: [:index]
    resources :items, only: [:index, :show], controller: :merchant_items
    resources :invoices, only: [:index, :show], controller: :merchant_invoices

  end

end
