class Admin::MerchantsController < ApplicationController
  def index
    @enabled_merchants = Merchant.enabled_merchants
    @disabled_merchants = Merchant.disabled_merchants
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    if params[:enable] != nil
      merchant.update(status: true)
      redirect_to admin_merchants_path
    elsif params[:disable] != nil
      merchant.update(status: false)
      redirect_to admin_merchants_path
    else
      merchant.update(merchant_params)
      flash[:success] = 'Merchant updated'
      redirect_to admin_merchant_path(merchant)
    end

  end

  private
  def merchant_params
    params.require(:merchant).permit(:name)
  end
end
