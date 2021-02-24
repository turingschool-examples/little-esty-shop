Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resources :merchants, only: [:dashobard]

  # get  "/merchant/:merchant_id/dashboard", to: "merchants#dashboard"
  scope :merchant do
    get "/:merchant_id/dashboard", to: "merchants#dashboard"
  end
end
