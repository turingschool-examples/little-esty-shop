Rails.application.routes.draw do
  
  resources :merchant do
    resources :items, :invoices
    resources :dashboard, only: [:index]
  end

end
