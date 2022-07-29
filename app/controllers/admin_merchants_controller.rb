class AdminMerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
    if params[:enable]
      merchant = Merchant.find(params[:id])
      merchant.update(status: "enabled")
      merchant.save
    elsif params[:disable]
      merchant = Merchant.find(params[:id])
      merchant.update(status: "disabled")
      merchant.save
    end
  end
  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant_edit = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(name: params[:name])
    merchant.save
    flash[:notice] = "Merchant successfully updated!"
    redirect_to "/admin/merchants/#{merchant.id}"
  end
end
