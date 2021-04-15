Rails.application.routes.draw do
  resources :merchant do
    resources :dashboard
    resources :invoices, only: [:index, :show]
  end
end
