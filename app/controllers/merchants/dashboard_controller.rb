class Merchants::DashboardController < ApplicationController
  def show
    @merchant = Merchant.find(params[:id])
  end
end
