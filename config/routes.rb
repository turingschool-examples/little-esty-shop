Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resources :admin do
    resources :merchants
    resources :invoices
  end

  get '/merchants/:id/dashboard', to: 'merchants#show'


end
