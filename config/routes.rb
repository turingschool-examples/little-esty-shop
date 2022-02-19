Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html



  # Routes Aedan created below
  resources :merchants, module: :merchant do 
    resources :invoices
  end 
  # End routes Aedan created

end
