  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  namespace(:admin) do
    resources(:merchants,     only: [:index, :show, :edit, :update])
    resources(:invoices,     only: [:index, :show, :update])
  end

  resources(:admin,   only: [:index]) do
    resources(:merchants,     only: [:index])
    resources(:invoices,     only: [:index, :show])
  end

  # get("/merchants/:id/dashboard",   to: "merchants_dashboard#index")
  get("/merchants/:id/dashboard",   to: "merchants#show")
  get("/merchants/:id/items",   to: "items#index")
  get("/merchants/:id/invoices",   to: "invoices#index")
  get("/merchants/:id/items/:id",   to: "items#show")
  get("/merchants/:id/invoices/:id",   to: "invoices#show")
  get("/merchants/:id/items/:id/edit",   to: "items#edit")
  patch("/items/:id",   to: "items#update")
end
