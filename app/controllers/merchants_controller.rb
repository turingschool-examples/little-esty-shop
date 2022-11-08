class MerchantsController < ApplicationController
  def create
    @merchant = Merchant.new(merchant_params)
    @merchant.save

    redirect_to '/admin/merchants'
  end

  private
  def merchant_params
    params.permit(:name)
  end
end