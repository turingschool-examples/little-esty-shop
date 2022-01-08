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
    merchant = Merchant.find(params[:id])
    merchant.update(merch_params)
    redirect_to admin_merchant_path(merchant.id)
    flash[:notice] = "Successfully Updated Merchant Information"
  end

  private

  def merch_params
    params.require(:merchant).permit(:name)
  end
end
