class Admin::MerchantsController < ApplicationController 
  def show
    @merchant = Merchant.find(params[:id])
  end

  def index
    @merchants = Merchant.all
    @top_merchants = Merchant.top_5_by_revenue
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
    @merchant = Merchant.find(params[:id])
  end
  
  def new
    @merchant = Merchant.new
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(merchant_params)
    redirect_to admin_merchant_path(merchant.id), notice: "Merchant successfully updated!"
  end

  private
    def merchant_params
      params.require(:merchant).permit(:name)
    end
end