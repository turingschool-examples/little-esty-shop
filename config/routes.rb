Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'application#welcome'
  resources :merchants do
    resources :dashboard, only: [:index]
    resources :items, only: [:index, :show, :edit, :update]
    resources :invoices, only: [:index]
  end

  resources :admin do
  end

end
