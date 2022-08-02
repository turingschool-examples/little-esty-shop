class AdminController < ApplicationController
  def index 
    @merchants = Merchant.all
  end
end