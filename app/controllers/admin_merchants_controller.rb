class AdminMerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
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
