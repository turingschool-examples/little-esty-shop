class WelcomeController < ApplicationController
  def index
    @merchants = Merchant.all
  end
end
