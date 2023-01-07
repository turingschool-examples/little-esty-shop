class HomeController < ApplicationController
  def index
    @merchants = Merchant.all
  end
end
