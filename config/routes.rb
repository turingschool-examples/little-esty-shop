Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/' ,to: "welcome#index"

  resources :merchants, only:[:show] do
    resources :items, except:[:destroy]
    resources :dashboard, only:[:index]
  end

  post '/merchants/:merchant_id/invoice_items', to: 'invoice_items#update'
  get '/admin/merchants/:id/dashboard', to: "admin/dashboard#index"
  get '/merchants/:id/invoices', to: 'merchant_invoices#index'
  get '/merchants/:merchant_id/invoices/:id', to: 'merchant_invoices#show'
end
