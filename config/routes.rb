Rails.application.routes.draw do
  get 'admin/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'application#welcome'

  resources :merchants
  resources :admin

  namespace :merchants do
    resources :items
    resources :invoices
  end

  # namespace :admin do
  #   resources :merchants
  #   resources :invoices
  # end
  get "/admin/invoices", to: "admin_invoices#index"
  get "/admin/invoices/:id", to: "admin_invoices#show"

  # resources :merchant, only: [:show] do
  #   resources :dashboard, only: [:index]
  #   resources :items, except: [:destroy]
  #   resources :item_status, only: [:update]
  #   resources :invoices, only: [:index, :show, :update]
  # end
  #
  # namespace :admin do
  #   resources :dashboard, only: [:index]
  #   resources :merchants, except: [:destroy]
  #   resources :merchant_status, only: [:update]
  #   resources :invoices, except: [:new, :destroy]
  # end
end
