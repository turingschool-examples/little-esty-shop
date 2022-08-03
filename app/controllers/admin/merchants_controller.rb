class Admin::MerchantsController < ApplicationController

  def index
    @merchants = Merchant.all
    @top_5_merchants = Merchant.top_5_merchants
    @enabled_merchants = Merchant.enabled_merchants
    @disabled_merchants = Merchant.disabled_merchants
  end

  def new
  end

  def create
    if merchant_params[:merchant_name] != ""
      merchant = Merchant.create(name: merchant_params[:merchant_name])

      redirect_to admin_merchants_path, notice: "#{merchant.name} created!"
    else
      redirect_to new_admin_merchant_path, notice: "Error, please complete all fields"
    end
  end

  def show
    @merchant = Merchant.find(params[:id])
  end
  
  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])

    if params[:commit] == "Disable"
      @merchant.update(status: params[:status])
      redirect_to admin_merchants_path
    elsif params[:commit] == "Enable"
      @merchant.update(status: params[:status])
      redirect_to admin_merchants_path
    else
      redirect_to admin_merchants_path, notice: "ERROR PROCESSING REQUEST!"
    end
  end
  
private
  def merchant_params
    params.permit(:status, :merchant_name)
  end
end