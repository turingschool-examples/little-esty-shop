class MerchantsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:id])
  end
end
