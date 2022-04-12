Rails.application.routes.draw do
  root "welcome#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/merchants/:id/dashboard', to: 'merchants#show'
  get '/merchants/:id/items', to: 'merchants#item_index'
  get '/merchants/:id/invoices', to: 'merchants#invoice_index'

  get '/items/new', to: 'items#new'
  post '/items', to: 'items#create'
end
