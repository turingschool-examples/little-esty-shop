Rails.application.routes.draw do
  resources :merchants do
    resources :dashboard, controller: 'merchant_dashboard', only: [:index]
  end
end
