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
    if params[:status].present?
      merchant.update_status(params[:status])
      redirect_to admin_merchants_path
    else
      merchant.update(merchant_params)
      flash[:success] = "#{merchant.name} has been successfully updated!"
      redirect_to admin_merchant_path
    end
  end

private
    def merchant_params
      params.require(:merchant).permit(:name)
    end
end
