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
    merchant = Merchant.find(merchant_params[:id])
  
    if merchant.update(name: merchant_params[:merchant][:merchant_name])
      redirect_to admin_merchant_path(merchant.id) 
      flash[:info] = "Your changes have been successfully updated"
    else
      redirect_to edit_admin_merchant_path(merchant.id)
      flash[:error] = "Error: Invalid form entry"
    end
  end
  
  private
  
  def merchant_params
    params.permit(:id, merchant: :merchant_name)
    # x = params[:merchant].permit(:merchant_name)
  end
end