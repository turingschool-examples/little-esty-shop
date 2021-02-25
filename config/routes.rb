Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resources :merchants, only: [:dashobard]

  # get  "/merchant/:merchant_id/dashboard", to: "merchants#dashboard"
  scope :merchant do
    get "/:merchant_id/dashboard", to: "merchants#dashboard"
    get "/:merchant_id/items", to: "merchant_items#index", as: "merchant_items"
    get "/:merchant_id/items/:item_id", to: "merchant_items#show", as: "merchant_item"
    get "/:merchant_id/invoices", to: "invoices#index", as: "merchant_invoices"
  end

  resources :admin, only: [:index]

  namespace :admin do
    resources :merchants, only: [:index, :show, :edit, :update ]
    resources :invoices
  end
end
