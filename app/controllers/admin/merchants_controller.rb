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
    if merchant_params[:status].present?
      @merchant.toggle_status
      redirect_to admin_merchants_path
    else
      @merchant.update(merchant_params)
      flash[:notice] = "Merchant successfully updated"
      redirect_to admin_merchant_path(@merchant)
    end
  end

  private
  def merchant_params
    params.require(:merchant).permit(:name, :status)
  end
end