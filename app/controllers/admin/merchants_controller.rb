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
    @merchant = Merchant.find(params[:id])
    @merchant.update(admin_merchant_params)
    if !params[:merchant][:status].nil?
      redirect_to admin_merchants_path
    else
      redirect_to admin_merchant_path(@merchant)
    end
  end

  private
  def admin_merchant_params
    params.require(:merchant).permit(:name, :status)
  end
end