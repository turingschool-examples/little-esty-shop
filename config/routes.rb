Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/merchants/:id/dashboard', to: 'merchants#show'

  get '/merchants/:id/invoices', to: 'merchants/invoices#index'
  get '/merchants/:id/invoices/:id', to: 'merchants/invoices#show'
  
  resources :merchants do
    resources :items, only: [:index, :show, :edit, :update]
    resources :invoices, only: [:index, :show]
  end
end
