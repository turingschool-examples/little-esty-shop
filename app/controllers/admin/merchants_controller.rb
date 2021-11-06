class Admin::MerchantsController < ApplicationController

  def index
    @merchants = Merchant.all
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    if merchant.update(merchant_params)
      flash[:notice] = "Merchant has been updated."
      if params[:merchant][:status]
        redirect_to admin_merchants_path
      else
        redirect_to admin_merchant_path(merchant)
      end
    else
      flash[:alert] = "Please enter a valid name"
      redirect_to admin_merchant_path(merchant)
    end
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  private
    def merchant_params
      params.require(:merchant).permit(:name, :status)
    end
end
