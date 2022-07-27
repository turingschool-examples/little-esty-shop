Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/merchants/:id/invoices', to: 'invoices#index'

  get '/merchants/:id/invoices/:id', to: 'invoices#show'

  patch '/merchants/:id/invoices/:id', to: 'invoices#update'

end
