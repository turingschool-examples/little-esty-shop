class MerchantsController < ApplicationController

  def dashboard
    @merchant = Merchant.find(params[:id])
  end

  def index
    redirect_to "/admin/merchants"
  end
end
