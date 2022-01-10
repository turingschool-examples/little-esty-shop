class MerchantsController < ApplicationController

  def dashboard
    @merchant = Merchant.find(params[:id])
  end

  def index
    redirect_to "/admin/merchants"
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(merchant_params)
    redirect_to "/admin/merchants"
  end


  private

  def merchant_params
    params.permit(:name, :status)
  end
end
