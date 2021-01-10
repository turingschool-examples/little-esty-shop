class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    if result = merchant.update(name: params[:name])
      flash.notice = "Successfully Updated Info"
      redirect_to admin_merchant_path(params[:id])
    else
      flash.alert = merchant.errors.full_messages
      @merchant = merchant
      render "edit"
    end
  end
end
