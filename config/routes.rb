Rails.application.routes.draw do
  resources :merchant do
    resources :dashboard, only: [:index]
    resources :invoices, only: [:index, :show]
    resources :items, only: [:index, :show]
  end
end
