Rails.application.routes.draw do

# get '/merchant', to: 'merchants#dashboard'
  resources:merchants, module: :merchant do
    resources:dashboard, only: [:index]
    resources:items
    resources:invoices
  end
end
