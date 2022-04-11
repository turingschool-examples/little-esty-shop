Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :merchants, only: [:show] do
    resources :items, only: [:index, :show]
    resources :invoices, only: [:index, :show]
    resources :dashboard, only: [:index]
  end

  get '/admin', to: 'application#admin_dashboard'
  get '/admin/merchants', to: 'application#admin_merchants_dashboar
end
