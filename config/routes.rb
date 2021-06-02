Rails.application.routes.draw do

  get 'merchants/:id/dashboard', to: 'merchants#dashboard'
  resources :merchants, only: :index do
    resources :items, only: :index
    resources :invoices, only: :index
  end
end
