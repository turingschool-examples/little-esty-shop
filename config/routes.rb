Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'
  
  resources :merchants, only: [:show] do
    resources :dashboard, only: [:index]
    resources :items, except: :delete
    resources :invoices, only: [:index, :show]
    # get "/dashboard", controller: :merchants, action: :show, as: "dashboard"
  end
end
