class MerchantsController < ApplicationController

  def dashboard
    @merchant = Merchant.find(params[:id])
  end

  def items_index
    @merchant = Merchant.find(params[:id])
  end
end
