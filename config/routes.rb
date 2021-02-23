Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :merchants do
    scope module: :merchant do
      resources :dashboard, only: [:index]
      resources :items
      resources :invoices
    end
  end
end
