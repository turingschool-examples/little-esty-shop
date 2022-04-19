class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
      if merchant.status == nil || merchant.status == "disabled"
        merchant.update!(status: "enabled")
        merchant.save
      else
        merchant.update!(status: "disabled")
        merchant.save
      end
      redirect_to "/admin/merchants"
  end
end
