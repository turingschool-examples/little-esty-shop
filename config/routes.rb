Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/' ,to: "welcome#index"

  # get '/merchants/:id/dashboard', to: "dashboard#index"
  # get '/merchants/:id/items', to: "merchant_items#index"
  resources :merchants, only:[:show] do
    resources :items, except:[:destroy]
    resources :dashboard, only:[:index]
  end

  get '/merchants/:id/invoices/:id', to: "merchant_invoices#show"

  # get '/merchants/:id/items/new', to: "merchant_items#new"
  # post '/merchants/:id/items', to: "merchant_items#create"
end
