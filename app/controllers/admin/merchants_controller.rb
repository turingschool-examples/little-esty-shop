class Admin::MerchantsController < ApplicationController

  def index
    @merchants = Merchant.all
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(merchant_params)
    flash[:notice] = "Merchant name has been updated."
    redirect_to admin_merchant_path(merchant)
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  private
    def merchant_params
      params.require(:merchant).permit(:name)
    end
end
