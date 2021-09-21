class MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end
  #
  def show
    @merchant = Merchant.find(params[:merchant_id])
    @five_best = @merchant.five_best_customers
  end
end
