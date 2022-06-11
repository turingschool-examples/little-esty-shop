Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'application#welcome'

  get "/merchants/:merchant_id/dashboard", to: 'merchants#show'

  resources :merchants, only: [:show] do
    resources :items, controller: :merchant_items
    resources :bulk_discounts
  end

  resources :merchants, only: [:show] do
    resources :invoices, only: [:index, :show], controller: :merchant_invoices
    resources :invoices, only: [:update], controller: :invoice_items
  end

  get "/admin", to: "admin#show"

  scope :admin do
    resources :invoices, only: [:index, :show, :update], controller: :admin_invoices
    resources :merchants, only: [:new, :create, :show, :edit, :update, :index], param: :merchant_id, controller: :admin_merchants
  end
end
