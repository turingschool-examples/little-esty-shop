class MerchantsController < ApplicationController
  def new
    @merchant = Merchant.find(params[:id])
  end

  def show
    @merchant = Merchant.find(params[:id])
  end
end

