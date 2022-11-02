Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/merchants/:merchant_id/dashboard", to: "merchant_dashboards#index"
  get "/merchants/:merchant_id/invoices", to: "merchant_invoices#index"

  resources :merchants, only: [:index] do 
    resources :items, except: [:destroy]
  end
  
  get "/admin", to: "admin#index"
  
  namespace(:admin) do
    resources(:merchants) do
    end
  end
end
