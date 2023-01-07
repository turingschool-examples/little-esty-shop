class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
    @merchants_enabled = Merchant.group_by_status("enabled")
    @merchants_disabled = Merchant.group_by_status("disabled")
  end

  def new

  end

  def create
    
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    if merchant_params[:status].present?
      @merchant.toggle_status
      redirect_to admin_merchants_path
    else
      @merchant.update(merchant_params)
      flash[:notice] = "Merchant successfully updated"
      redirect_to admin_merchant_path(@merchant)
    end
  end

  private
  def merchant_params
    params.require(:merchant).permit(:name, :status)
  end
end