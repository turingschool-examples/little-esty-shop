Rails.application.routes.draw do
  resources:merchants, module: :merchant do
    resources:dashboard, only: [:index]
    resources:items
    resources:invoices
  end

  resources :admin, only: [:index]

  namespace :admin do
    resources :invoices, only: [:index, :show]
    resources :merchants
  end
end
