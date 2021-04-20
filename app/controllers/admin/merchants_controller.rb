class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
    @enabled_merchants = Merchant.enabled
    @disabled_merchants = Merchant.disabled
    @top_five_merchants = Merchant.top_five_by_merchant_revenue
  end

  def new
  end

  def create
    merchant = Merchant.new(merchant_params)
    merchant.save
    redirect_to admin_merchants_path
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    require "pry"; binding.pry
    if params[:status]
      @merchant.update(merchant_params)
      redirect_to admin_merchants_path
    else
      @merchant.update(merchant_params)
      redirect_to "/admin/merchants/#{@merchant.id}"
      flash[:notice] = "Update Successful"
    end
  end
end

private
  def merchant_params
    params.permit(:name, :status)
  end
