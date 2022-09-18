  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  resources(:merchants,   only: [:show]) do
    resources(:items,     only: [:index, :show, :edit])
    resources(:invoices,     only: [:index, :show])
  end

  namespace(:admin) do
    resources(:merchants,     only: [:index, :show, :edit, :update])
    resources(:invoices,     only: [:index, :show, :update])
  end

  resources(:admin,   only: [:index]) do
    resources(:merchants,     only: [:index])
    resources(:invoices,     only: [:index, :show])
  end

  resources(:items,   only: [:update])
  get("/merchants/:id/dashboard",   to: "merchants#show")
end
