Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/merchants/:id/dashboard', to: 'merchants/dashboard#show'

  resources :merchants, only: [] do
    scope module: "merchants" do
      resources :items, only: [:index, :show, :edit, :update]
      resources :invoices, only: [:index, :show]
    end
  end

  get '/admin', to: 'admin/dashboard#index'

  namespace :admin do
    resources :merchants, except: :destroy
    resources :invoices, only: [:index, :show]
  end
end
