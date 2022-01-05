class MerchantsController < ApplicationsController

  def dashboard
    @merchant = Merchant.find(params[:id])
  end
end
