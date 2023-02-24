class Admin::MerchantsController < ApplicationController

  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    if @merchant.status == "enabled"
      @merchant.update! status: 1
    else
      @merchant.update! status: 0
    end
    redirect_to "/admin/merchants"
  end
end