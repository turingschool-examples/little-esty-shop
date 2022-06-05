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
    old_enabled = merchant.enabled
    merchant.update(merchant_params)
    merchant.save

    if old_enabled == merchant.enabled
      flash[:notice] = "Merchant Information Has Been Successfully Updated"
      redirect_to admin_merchant_path(merchant.id)
    else
      redirect_to admin_merchants_path
    end
  end

  private
  def merchant_params
    params.permit(:id, :name, :enabled)
  end
end
