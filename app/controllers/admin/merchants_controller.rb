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
    if params[:merchant].include?(:name)
      flash.notice = "Merchant was successfully updated!" 
      redirect_to(admin_merchant_path(merchant))
    else
      redirect_to(admin_merchants_path)      
    end
    
  end

  def new
    @merchant = Merchant.new
  end

  def create
    @merchant = Merchant.create!(merchant_params)
    redirect_to(admin_merchants_path)
  end

  private 

  def merchant_params
    params.require(:merchant).permit(:name, :active_status)
  end
end