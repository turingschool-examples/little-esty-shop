class AdminMerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    if params[:update_status_to] == "disabled"
      merchant.disabled!
    elsif params[:update_status_to] == "enabled"
      merchant.enabled!
    end
    redirect_to "/admin/merchants"
  end
end
