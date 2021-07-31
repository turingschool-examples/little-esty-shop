Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :customers
  resources :merchants, module: :merchant do
    resources :items
    resources :invoices
    get '/dashboard', to: 'merchants#dashboard'
  end

  resources :items, only: [:edit, :update, :new, :create]

end
