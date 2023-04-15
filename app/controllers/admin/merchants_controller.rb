class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
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
    redirect_to admin_merchant_path(@merchant)
  end

  private
  def admin_merchant_params
    params.require(:merchant).permit(:name)
  end
end