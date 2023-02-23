Rails.application.routes.draw do
  resources :merchants do
    resources :dashboard, only: [:index], controller: "merchant_dashboards"
  end
end
