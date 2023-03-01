class Admin::MerchantsController < ApplicationController

  def index
    @merchants = Merchant.all
    @enabled = Merchant.group_by_status("enabled")
    @disabled = Merchant.group_by_status("disabled")
    @top_5 = Merchant.top_five_revenue
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
      redirect_to "/admin/merchants"
    else
      @merchant.update!(merchant_params)
      flash[:notice] = "Successfully updated"
      redirect_to "/admin/merchants/#{@merchant.id}"
    end
  end


  def create
    merchant = Merchant.create!(merchant_params)
    redirect_to admin_merchants_path
  end
  
  private
  def merchant_params
    params.permit(:name, :status)
  end
end