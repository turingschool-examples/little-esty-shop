class Admin::MerchantsController < ApplicationController
  def index
    @enabled_merchants = Merchant.group_by_status("Active")
    @disabled_merchants = Merchant.group_by_status("Disabled")
  end

  def new
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    @merchant.update(merchant_params)
    if params[:status]
      redirect_to admin_merchants_path
    else
      redirect_to admin_merchant_path(@merchant)
    end
  end

  def create
    @merchant = Merchant.create!(merchant_params)
    redirect_to admin_merchants_path
  end

  private
  def merchant_params
    params.permit(:name, :status)
  end
end
