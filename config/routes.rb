Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :merchants, only: [:index] do
    resources :items, only: [:index, :show, :edit, :update]
  end

  get '/merchants/:merchant_id/invoices', to: 'merchant_invoices#index'
  get '/merchants/:merchant_id/invoices/:id', to: 'merchant_invoices#show'
  post '/merchants/:merchant_id/invoices/:id', to: 'merchant_invoices#update'
end
