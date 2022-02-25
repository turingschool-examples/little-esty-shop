class Admin::MerchantsController < ApplicationController

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    if merchant.name != params[:name]
      merchant.update!(name: params[:name])
      redirect_to admin_merchant_path(merchant)
      flash[:notice] = "#{merchant.name} has been updated"
    else
      redirect_to admin_merchant_path(merchant)
    end
  end
end
