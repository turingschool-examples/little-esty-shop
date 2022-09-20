  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  namespace(:admin) do
    resources(:merchants,     only: [:index, :show, :edit, :update, :new, :create])
    resources(:invoices,     only: [:index, :show, :update])
  end

  resources(:admin,   only: [:index]) do
    resources(:merchants,     only: [:index])
    resources(:invoices,     only: [:index, :show])
  end

  resources(:items,   only: [:update])

  resources(:merchants,   only: [:show]) do
    get("/dashboard",     to: "merchants#show")
    resources(:invoices,     only: [:index, :show])
    resources(:items,     only: [:index, :show, :new, :create, :edit, :update])
    resources(:invoices,     only: [:index, :show, :update])
    resources(:items,     only: [:index, :show, :new, :edit, :create, :update])
  end

  get("/merchants/:id/items/:id",   to: "items#show")
end
