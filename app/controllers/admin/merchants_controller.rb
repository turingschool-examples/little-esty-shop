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
    if @merchant.update(merchant_params)
      redirect_to admin_merchant_path(@merchant.id)
      flash[:alert] = "Update Successful"
    else
      redirect_to edit_admin_merchant_path(@merchant.id)
      flash[:alert] = "Unable to Update Merchant"
    end
  end

  private

  def merchant_params
    params.permit(:name)
  end
end
