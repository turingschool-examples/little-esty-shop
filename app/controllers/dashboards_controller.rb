class DashboardsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    binding.pry
    @customers = @merchant.customers
  end
end
