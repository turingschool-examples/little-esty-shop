Rails.application.routes.draw do
  resources :merchants do
    resources :items, only: [:index]
    resources :invoices, only: [:index]
    resources :dashboard, only: [:index], controller: "merchant_dashboards"
  end
end
