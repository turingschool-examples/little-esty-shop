  Rails.application.routes.draw do

    resources :merchants, only: [:show, :index], module: :merchant do
      resources :invoices
      resources :items
    end

end
