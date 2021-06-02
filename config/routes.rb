Rails.application.routes.draw do

  get 'merchants/:id/dashboard', to: 'merchants#dashboard'
  get 'merchants/:id/items', to: 'merchants#items_index' #????
  get 'merchants/:id/invoices', to: 'merchants#invoices_index' #????


end
