Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :merchants, module: :merchants do
    get '/dashboard', to: 'dashboard#show', as: 'merchant_dashboard'
    resources :items
    resources :invoices
  end
end
