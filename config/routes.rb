Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'application#welcome'
  get '/admin/merchants', to: 'admin_merchants#index'
  get '/admin/merchants/:merchant_id', to: 'admin_merchants#show'
  get '/admin/merchants/:merchant_id/edit', to: 'admin_merchants#edit'
  patch '/admin/merchants/:merchant_id', to: 'admin_merchants#update'


  # resources :merchant, only: [:show]

#   resources :admin

  # namespace :merchants do
  #   resources :items
  #   resources :invoices
  # end


  # namespace :admin do
  #   resources :merchants
  #   resources :invoices

  resources :merchants
  resources :admin


  # namespace :merchants do
  #   get '/:id/dashboard', to: 'dashboard#index'
  #   get '/:id/items', to: 'items#index'
  #   get '/:id/invoices', to: 'invoices#index'
  # end

  # namespace :admin do
  #   resources :merchants
  #   resources :invoices
  # end
  # get "/admin/invoices", to: "admin_invoices#index"
  # get "/admin/invoices/:id", to: "admin_invoices#show"

  # resources :merchant, only: [:show] do
  #   resources :dashboard, only: [:index]
  #   resources :items, except: [:destroy]
  #   resources :item_status, only: [:update]
  #   resources :invoices, only: [:index, :show, :update]
  # end
  #
  namespace :admin do
    resources :dashboard, only: [:index]
    resources :merchants, except: [:destroy]
    resources :merchant_status, only: [:update]
    resources :invoices, except: [:new, :destroy]
  end
end
