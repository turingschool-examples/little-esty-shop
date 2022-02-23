Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/merchants/:id/dashboard', to: 'merchants#show'




#  get '/merchants/:id/invoices', to: 'invoices#index'
#  get '/merchants/:id/invoices/:id', to: 'invoices#show'
resources :merchants, only:[] do
  resources :invoices, only: [:index, :show]
  resources :merchant_items, only: [:index, :new, :show, :create, :edit, :update]
end


#  get '/merchants/:merchant_id/items', to: 'merchant_items#index'
#  get '/merchants/:merchant_id/items/new', to: 'merchant_items#new'
#  post '/merchants/:merchant_id/items/', to: 'merchant_items#create'
#  get '/merchants/:merchant_id/items/:item_id', to: 'merchant_items#show'
#  get '/merchants/:merchant_id/items/:item_id/edit', to: 'merchant_items#edit'
#  patch '/merchants/:merchant_id/items/:item_id', to: 'merchant_items#update'
  namespace :admin  do
    resources :merchants, only: [:index, :show, :edit, :update]
  end
#  get '/admin/merchants', to: 'admin/merchants#index'
#  get '/admin/merchants/:id', to: 'admin/merchants#show'
#  get '/admin/merchants/:id/edit', to: 'admin/merchants#edit'
#  patch '/admin/merchants/:id', to: 'admin/merchants#update'

end
