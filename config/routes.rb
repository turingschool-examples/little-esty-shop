Rails.application.routes.draw do

  root 'welcome#index'
  get '/refresh', to: 'welcome#refresh'

  resources :merchants, only: [:show, :index], module: :merchant do
      resources :items
      resources :invoices
      resources :dashboard, only: [:index]
  end

  namespace :admin do
    resources only: [:index]
    resources :merchants
    resources :invoices
  end
end

# resources :merchants, module: :merchants do
#   get '/dashboard', to: 'dashboard#show', as: 'merchant_dashboard'
#   resources :items, except: :destroy
#   resources :invoices
# end
#
# namespace :admin do
#     get '/', to: 'dashboard#index'
#     resources :invoices, only: [:index, :show, :update]
#     resources :merchants, except: [:destroy]
#   end
