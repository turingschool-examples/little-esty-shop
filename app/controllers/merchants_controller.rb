class MerchantsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:id])
    @top5 = Merchant.top5(@merchant.id)
  end
end