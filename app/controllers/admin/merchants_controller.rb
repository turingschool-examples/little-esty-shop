class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
    @enabled_merchants = Merchant.enabled
    @disabled_merchants = Merchant.disabled
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def create
    merchant = Merchant.new(merchant_params)
    merchant.save
    redirect_to admin_merchants_path
  end

  def new
  end

  def update
    merchant = Merchant.find(params[:id])
    if params[:status]
      merchant.update(merchant_params)
      redirect_to admin_merchants_path
    end
  end
end

private
  def merchant_params
    params.permit(:name, :status)
  end
