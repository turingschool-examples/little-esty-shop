Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/' ,to: "welcome#index"

  get '/merchants/:id/dashboard', to: "dashboard#index"
  get '/merchants/:id/items', to: "merchant_items#index"

end
