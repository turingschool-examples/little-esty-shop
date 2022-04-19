Rails.application.routes.draw do
  root "welcome#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/merchants/:id/dashboard", to: "merchants#show"
  # get '/merchants/:id/items', to: 'merchants#item_index'
  # get '/merchants/:id/items/new', to: 'merchants#new_item'
  # get '/merchants/:id/invoices', to: 'merchants#invoice_index'
  get "/items/:id/edit", to: "items#edit"
  patch "/items/:id", to: "items#update"
  get "/items/:id", to: "items#show"

  resources :merchants, only: [:show, :edit] do
    resources :items, only: [:index, :new, :create, :update, :show]
    resources :invoices, only: [:index, :show]
  end

  get "/admin", to: "admin/dashboard#index"
  get "/admin/merchants", to: "admin/merchants#index"
  get "/admin/invoices", to: "admin/invoices#index"
<<<<<<< HEAD
  get "/admin/merchants/new", to: "admin/merchants#new"
=======
  get "/admin/invoices/:id", to:"admin/invoices#show"
  get "/admin/merchants/:id", to:"admin/merchants#show"
  patch "/admin/merchants/:id", to: "admin/merchants#update"
  get "admin/merchants/:id/edit", to: "admin/merchants#edit"
>>>>>>> main
end
