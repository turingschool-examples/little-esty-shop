class MerchantsController < ApplicationController
  def dashboard
    @merchant = Merchant.find(params[:id])
    @favorite_customers = Customer.favorite_customers(params[:id])
  end

  private
  def merchant_params
    params.permit(:name)
  end
end