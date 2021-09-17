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
    merchant.update(merchant_params)
    flash[:success] = "#{merchant.name} has been successfully updated!"
    redirect_to admin_merchant_path
  end

private
    def merchant_params
      params.require(:merchant).permit(:name)
    end
end
