Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/merchants/:id/dashboard', to: 'merchants/dashboard#show', as: 'merchant_dashboard'

  resources :merchants, only: [] do
    scope module: "merchants" do
      resources :items, only: [:index, :show, :edit, :update]
    end
  end

  get '/admin', to: 'admin/dashboard#index'

  namespace :admin do
    resources :merchants, except: :destroy
  end
end
