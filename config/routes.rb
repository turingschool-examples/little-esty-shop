Rails.application.routes.draw do

  resources:merchant do
    resources:dashboard, only: [:index]
  end
end
