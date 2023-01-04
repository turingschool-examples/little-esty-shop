class MerchantsController < ApplicationController
  def index
  end

  def show
    @merchant = Merchant.find(params[:id])
    @top_customers = @merchant.top_five_customers
  end
end