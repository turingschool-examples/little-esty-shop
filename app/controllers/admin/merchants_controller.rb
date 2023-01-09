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
    # require 'pry'; binding.pry
    merchant = Merchant.find(params[:id])
    if merchant.update(merchant_params)
      flash[:alert] = "Successfully updated"
      if params[:merchant][:name]
        redirect_to admin_merchant_path(merchant)
      else
        redirect_to admin_merchants_path
      end
    else
      redirect_to edit_admin_merchant_path(merchant)
      flash[:alert] = "Update failed"
    end
  end

  private

  def merchant_params
    params.require(:merchant).permit(:name, :status)
  end
end