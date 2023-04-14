class MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(merchant_params)
    redirect_to admin_merchants_path
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
  end

  private
  def merchant_params
    params.require(:merchant).permit(:name, :is_enabled)
  end
end