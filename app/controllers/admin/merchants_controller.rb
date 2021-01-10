class Admin::MerchantsController < ApplicationController
  def index
    @enabled_merchants = Merchant.where(enabled: true)
    @disabled_merchants = Merchant.where(enabled: false)
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    if merchant.update(merchant_params)
      flash.notice = "Successfully Updated Info"
      if params[:name]
        destination = admin_merchant_path(params[:id])
      else
        destination = admin_merchants_path
      end
      redirect_to destination
    else
      flash.alert = merchant.errors.full_messages
      @merchant = merchant
      render "edit"
    end
  end

  def new
  end

  private

  def merchant_params
    params.permit(:name, :enabled)
  end
end
