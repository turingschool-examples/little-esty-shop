class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def new
  end

  def create
    Merchant.create!(merchant_params)
    redirect_to admin_merchants_path
  end

  def switch
    @merchant = Merchant.find(params[:id])
    Merchant.update(@merchant.id, enabled: !@merchant.enabled)
    redirect_to "/admin/merchants"
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    if @merchant.update(merchant_params)
      redirect_to admin_merchant_path(params[:id])
      flash[:alert] = "Update Successful"
    end
  end

  def enable
    @merchant = Merchant.find(params[:id])
    if params[:enabled] == "true"
      @merchant.update(enabled: true)
      redirect_to admin_merchants_path
    else
      @merchant.update(enabled: false)
      redirect_to admin_merchants_path
    end
  end

  private

  def merchant_params
    params.permit(:name, :enabled)
  end
end
