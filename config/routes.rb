Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :merchants, only: [:index] do
    resources :dashboard, only: [:index]
<<<<<<< HEAD
    resources :items
=======
    resources :items, only: [:index]
    resources :invoices, only: [:index]
>>>>>>> 6a3e31d475c84a7c41042ae44dcf3e00737f3035
  end
end
