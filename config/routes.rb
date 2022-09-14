Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/merchants/:id/dashboard', to: 'merchants#dashboard'

  resources :merchants do
    resources :items, only: [:index, :show, :edit]
  end

  patch '/merchants/:merchant_id/items/:id', to: 'items#update'

end
