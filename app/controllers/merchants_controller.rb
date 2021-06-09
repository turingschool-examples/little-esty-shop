class MerchantsController < ApplicationController
  def dashboard
    @merchant = Merchant.find(params[:id])
    @top_customers = Customer.top_customers(@merchant.id)
  end
end
