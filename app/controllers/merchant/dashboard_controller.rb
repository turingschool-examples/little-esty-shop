class Merchant::DashboardController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    #@not_shipped = @merchant.not_shipped
  end


end
