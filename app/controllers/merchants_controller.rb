class MerchantsController < ApplicationController
  def dashboards
    @merchant = Merchant.find(params[:merchant_id])
  end

  def items
    @merchant = Merchant.find(params[:merchant_id])
  end
end