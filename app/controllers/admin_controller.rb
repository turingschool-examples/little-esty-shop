class AdminController < ApplicationController
  def dashboard
    @merchants = Merchant.all 
  end
end
