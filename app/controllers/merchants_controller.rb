class MerchantsController < ApplicationController

  def show
    @merchant = Merchant.find(merchant_params[:merchant_id])
  end

  private
  def merchant_params
    params.permit(:name, :merchant_id)
  end

end