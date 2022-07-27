Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :merchants do
    resources :dashboard, only: [:index]
    resources :items
<<<<<<< HEAD
    # resources :items, only: [:index]
=======
>>>>>>> 7a1362f9627cdde4fb1395ab4ea5889d93ba599f
    resources :invoices, only: [:index]
  end
  
end
