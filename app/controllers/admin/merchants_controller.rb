class Admin::MerchantsController < ApplicationController

  def index 
    @merchants = Merchant.all
  end

  def update 
    if params[:trigger]
      merchant = set_merchant
      merchant.change_status
      redirect_to admin_merchants_path
    end 
  end 

  def new
  
  end 

private 

  def set_merchant 
    @merchant = Merchant.find(params[:id])
  end 
end