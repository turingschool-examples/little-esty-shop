Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :admin, only: [:index]

  namespace :admin do
    resources :invoices, only: [:index, :show]
  end
  
end
