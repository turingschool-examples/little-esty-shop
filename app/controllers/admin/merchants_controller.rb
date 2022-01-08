class Admin::MerchantsController < ApplicationController

  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(admin_merchant_params[:id])
  end

  def edit
    @merchant = Merchant.find(admin_merchant_params[:id])
  end

private 

  def admin_merchant_params
    params.permit(:id, :name)
  end

end
