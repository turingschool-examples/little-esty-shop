Rails.application.routes.draw do
  namespace :merchants do
    get '/:id/items', to: 'items#index'
    get '/:id/items/new', to: 'items#new'
    post '/:id/items', to: 'items#create'
    get '/:id/items/:id', to: 'items#show'
    get '/:id/items/:id/edit', to: 'items#edit'
    patch '/:id/items/:id', to: 'items#update'
    get '/:id/dashboard', to: 'merchants#dashboard'
  end

  resources :admin, only: [:index]


  namespace :admin do   
    resources :invoices, only: [:index, :show]
    resources :merchants, only: [:index, :show]
  end
end
