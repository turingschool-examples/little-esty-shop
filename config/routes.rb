Rails.application.routes.draw do
  resources :merchants, only:[:show] do
    resources :items, except:[:delete]
    resources :invoices, only:[:index]
    resources :dashboard, only:[:index]
  end

  get "/merchants/:merchant_id/items/:id/change_status", to: 'items#change_status'

  resources :admin, controller: 'admin/dashboard', only: [:index]
  namespace :admin do
    resources :merchants, only: [:index, :show, :update, :create]
    resources :invoices, only: [:index, :show]
  end
end
