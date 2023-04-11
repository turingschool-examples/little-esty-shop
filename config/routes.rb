Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :merchants do
    resources :items, controller: 'merchant/items'
    get 'dashboard', to:'merchant/dashboard#show', on: :member
  end
end
