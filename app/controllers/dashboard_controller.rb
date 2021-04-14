class DashboardController < ApplicationController
  def index
    # Merchant.all
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show

  end
end
