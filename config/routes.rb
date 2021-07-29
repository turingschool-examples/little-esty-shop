Rails.application.routes.draw do
  resources :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/merchants/:id/dashboard', to: 'merchants#dashboard'
  get '/merchants/:id/items', to: 'merchant_items#index' #merchant/merchant_items#index'
  get '/merchants/:id/invoices', to: 'merchant_invoices#index' #merchant/merchant_invoices#index'


  #namespace merchants do

  # end
end
