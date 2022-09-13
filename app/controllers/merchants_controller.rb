class MerchantsController < ApplicationController
  def dashboard
    @merchant = Merchant.find(params[:id])
    @favorite_customers = @merchant.items.favorite_customers
  end

  private
  def merchant_params
    params.permit(:name)
  end
end