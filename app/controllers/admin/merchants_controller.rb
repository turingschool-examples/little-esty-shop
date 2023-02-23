class Admin::MerchantsController < ApplicationController 
  def show
    @merchant = Merchant.find(params[:id])
  end

  def index
    @merchants = Merchant.all
  end

  def new
  end

  def create 
    merchant = Merchant.new(merchant_params)
    if merchant.save
      redirect_to admin_merchants_path
    else 
      redirect_to new_admin_merchant_path
      flash[:alert] = "Error: #{error_message(merchant.errors)}"
    end
  end

  def merchant_params
    params.permit(:name)
  end
end