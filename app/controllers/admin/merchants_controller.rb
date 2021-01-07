class Admin::MerchantsController < ApplicationController
  before_action :set_merchant, only:[:show, :edit, :update]

  def index
    @merchants_enabled = Merchant.enabled
    @merchants_disabled = Merchant.disabled
  end
  
  def show
  end

  def edit
  end

  def update
    @merchant.update(merchant_params)
    if params[:merchant][:status]
      redirect_to admin_merchants_path
    else
      flash.notice = "Merchant #{@merchant.name} was updated successfully!"
      redirect_to admin_merchant_path(@merchant)
    end
  end

  private

  def set_merchant
    @merchant = Merchant.find(params[:id])
  end
  
  def merchant_params
    params.require(:merchant).permit(:name, :status)
  end
  
end