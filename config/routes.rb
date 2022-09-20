Rails.application.routes.draw do

  root to: 'welcome#index'

  
# scope module: 'merchant' do
  resources :merchants, except: [:show], module: 'merchant' do
    # namespace :merchant do
      # resources :merchant do
        resources :invoices, only: [:index, :show]
        resources :items, except: [:delete]
        resources :invoice_items, only: [:update]
      # end
    end
  
  get '/merchants/:merchant_id/dashboard', to: 'merchants#show'

  resources :admin, only: [:index]

  namespace :admin do
    resources :merchants
    resources :invoices, only: [:index, :show, :update]
  end
end
