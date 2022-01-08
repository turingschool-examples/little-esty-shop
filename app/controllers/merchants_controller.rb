class MerchantsController < ApplicationController
  def index

  end
  def show
    @merchant = Merchant.find(params[:id])
  end

end
