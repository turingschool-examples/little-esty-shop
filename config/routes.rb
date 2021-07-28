Rails.application.routes.draw do

  get '/', to: 'welcome#index'

  resources :merchants, only: [:show, :index] do
    # except is an alternative to the 'only:' kwarg (i.e. if 'only' becomes cumbersome)
    resources :items, :invoices
  end

  namespace :admin do
    resources :merchants, :invoices
  end

end
