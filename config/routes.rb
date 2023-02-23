Rails.application.routes.draw do
  
  resources :merchant do
    resources :items, :invoices
    resources :dashboard, only: [:index]
  end

  get '/admin', to: 'admin/dashboards#index'

end
