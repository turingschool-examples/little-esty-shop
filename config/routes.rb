Rails.application.routes.draw do
  root "welcome#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/merchants/:id/dashboard', to: 'merchants#show'

  get '/merchants/:id/invoices', to: 'merchants#invoice_index'

  resources :merchants, only: [:show] do
    resources :items, only: [:index, :new, :create, :update]
    resources :invoices, only: [:index]
  end

end
