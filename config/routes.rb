Rails.application.routes.draw do

  resources :admin, :only => [index]

  namespace :admin do
    resources :merchants, :only => [:index, :show] 
    resources :invoices, :only => [:index, :show]

    /admin/invoices/invoice_id
  end

  # get top 5 customers

  # member do
  #   get :delete
  # end


end
