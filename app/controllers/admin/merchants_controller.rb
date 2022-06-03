class Admin::MerchantsController < ApplicationController

  def index
    @merchants = Merchant.all
    @enabled_merchants = Merchant.enabled
    @disabled_merchants = Merchant.disabled
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(params.permit(:name))
    flash[:notice] = "You have successfully updated this Merchant!"
    redirect_to admin_merchant_path(merchant)
  end
end
