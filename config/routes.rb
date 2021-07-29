Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html



  # Admin routes
  namespace :admin do
    resources :merchants

    # "I broke your route! Ha!"

    resources :invoices
    # Hello Test Test.
  end
end
