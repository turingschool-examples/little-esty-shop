Rails.application.routes.draw do
  get '/', to: "welcome#index"
  get '/admin', to: 'admin#show'
  get '/merchants/:id/dashboard', to: 'merchants#show'

  resources :merchants do
    resources :items, except:[:destroy], controller: 'merchant_items'
    resources :invoices, only:[:index, :show, :update], controller: 'merchant_invoices'
  end

  resources :items, only:[:show, :update]
  resources :invoices, only:[:show]

  namespace :admin do
    resources :merchants
    resources :invoices
  end
end
