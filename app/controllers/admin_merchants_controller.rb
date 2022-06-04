class AdminMerchantsController < ApplicationController
  def index
    @merchant = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end
end
