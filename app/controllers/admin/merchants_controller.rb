class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
    @disabled_merchants = Merchant.disabled_merchants
    @enabled_merchants = Merchant.enabled_merchants
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(merchant_params[:id])
    if merchant_params[:status].present?
      merchant.update!(merchant_params)
      redirect_to admin_merchants_path
    else
      if merchant.update(name: merchant_params[:merchant][:merchant_name])
        redirect_to admin_merchant_path(merchant.id) 
        flash[:info] = "Your changes have been successfully updated"
      else
        redirect_to edit_admin_merchant_path(merchant.id)
        flash[:error] = "Error: Invalid form entry"
      end
    end
  end
  
  private
  
  def merchant_params
    params.permit(:id, :status, merchant: :merchant_name)
    # x = params[:merchant].permit(:merchant_name)
  end
end