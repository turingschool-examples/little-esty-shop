Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # resources :merchants  do 
  #   resources :items, only: [:index, :show]
  # end
  get 'merchants/:id/items', to: 'items#index'
  get 'merchants/:id/items/:item_id', to: 'items#show'

  namespace :admin do
    root to: 'dashboard#index', as: 'dashboard'
    resources :merchants, only: %i[index show]
    resources :invoices, only: %i[index]
  end
end
