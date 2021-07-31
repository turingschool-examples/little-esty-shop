class Admin:: MerchantsController < ApplicationController

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
    merchant = Merchant.find(params[:id])
    merchant.update(merchant_params)
    redirect_to admin_merchant_path(merchant)
    flash[:alert] = "YOUR MERCHANT HAS BEEN UPDATED."
  end

  def update_status
    merchant = Merchant.find(params[:id])
    if params[:status] == true
      merchant.disable
    elsif params[:status] == false
      merchant.enable
    else #params[:status] == nil
      merchant.update(status: params[:status])
    end
    redirect_to "/admin/merchants"
  end

  private
  def merchant_params
    params.permit(:name, :status)
  end
end
