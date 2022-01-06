Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :merchants do
    resources :dashboard, only: [:index]
    get '/items', to: 'merchant_items#index'
    get '/invoices', to: 'merchant_invoices#index'
  end
end
