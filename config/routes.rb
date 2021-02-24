Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resources :merchants, only: [:dashobard]

  # get  "/merchant/:merchant_id/dashboard", to: "merchants#dashboard"
  scope :merchant do
    get "/:merchant_id/dashboard", to: "merchants#dashboard"
    get "/:merchant_id/items", to: "items#index", as: "merchant_items"
    get "/:merchant_id/invoices", to: "invoices#index", as: "merchant_invoices"
  end

  resources :admin
  resources :admin_merchants
  resources :admin_invoices

end
