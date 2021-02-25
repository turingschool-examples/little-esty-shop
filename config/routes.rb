Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resources :merchants, only: [:dashobard]

  # get  "/merchant/:merchant_id/dashboard", to: "merchants#dashboard"
  scope :merchant do
    get "/:merchant_id/dashboard", to: "merchants#dashboard"

    get "/:merchant_id/items", to: "merchant_items#index", as: "merchant_items"
    get "/:merchant_id/items/:item_id", to: "merchant_items#show", as: "merchant_item"
    get "/:merchant_id/items/:item_id/edit", to: "merchant_items#edit", as: "merchant_item_edit"
    patch "/:merchant_id/items/:item_id", to: "merchant_items#update"

    get "/:merchant_id/invoices", to: "invoices#index", as: "merchant_invoices"
  end

  resources :admin
  resources :admin_merchants
  resources :admin_invoices

end
