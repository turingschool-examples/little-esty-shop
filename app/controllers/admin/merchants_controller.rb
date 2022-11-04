class Admin::MerchantsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:id])
  end
  
  def index
    @merchants = Merchant.all
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end 

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(merchant_params)
    redirect_to "/admin/merchants/#{merchant.id}"
    flash[:notice] = "Successfully Updated: #{merchant.name}"
  end
private
  def merchant_params
    params.permit(:id, :name)
  end
end