class Admin::MerchantsController < ApplicationController

  def index
    @merchants = Merchant.all
    @enabled_merchants = Merchant.enabled
    @disabled_merchants = Merchant.disabled
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    if params[:status]
      merchant.update(merchant_status_params)
      redirect_to admin_merchants_path
    else
      if merchant.update(merchant_params)
        flash[:notice] = "You have successfully updated this Merchant!"
        redirect_to admin_merchant_path(merchant)
      else
        flash[:notice] = "Please fill out all fields to update this Merchant!"
        redirect_to edit_admin_merchant_path(merchant)
      end
    end
  end

  private
    def merchant_params
      params.permit(:name)
    end

    def merchant_status_params
      params.permit(:status)
    end
end
