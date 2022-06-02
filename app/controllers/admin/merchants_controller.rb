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
    merchant.save
    flash[:notice] = "Merchant Information Has Been Successfully Updated"
    redirect_to admin_merchant_path(merchant.id)
  end

  private
  def merchant_params
    params.permit(:id, :name)
  end
end
