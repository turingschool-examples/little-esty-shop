class Admin::MerchantsController < ApplicationController
  def index
    # require 'pry'; binding.pry
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
      redirect_to admin_merchant_path(merchant.id)
      flash[:notice] = "Information has been updated"
  end

  private 
  def merchant_params
    params.permit(:name)
  end
end

