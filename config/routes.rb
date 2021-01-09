Rails.application.routes.draw do
<<<<<<< HEAD
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :repos
=======
  namespace :admin do
    resources :merchants, except: [:destoy]
    resources :invoices, only: [:index, :show, :update]
  end

  resources :merchants do
    resources :items
    resources :invoices
    resources :invoice_items, only: [:update]
    resources :dashboard, only: [:index]
  end

  resources :admin, controller: 'admin/dashboard', only: [:index]
>>>>>>> f27acbc9cb8bb655190c3c77fcf71bbe3333a014
end
