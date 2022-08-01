class DashboardController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @top_five_customers = Customer.top_five_customers_by_transaction(@merchant.id)
  end
end
