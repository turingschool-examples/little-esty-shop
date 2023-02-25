class Admin::MerchantsController < ApplicationController 
  def show
    @merchant = Merchant.find(params[:id])
  end

  def index
    @merchants = Merchant.all
    @top_merchants = Merchant.top_5_by_revenue
  end

  def new
  end

  def create 
    merchant = Merchant.new(merchant_params)
    merchant.save
    redirect_to admin_merchants_path
  end

  def merchant_params
    params.permit(:name)
  end

  def edit
    
  end
end