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
    redirect_to("/admin/merchants")
  end

  def switch
    @merchant = Merchant.find(params[:id])
    Merchant.update(@merchant.id, :enabled => !@merchant.enabled)
    redirect_to "/admin/merchants"
  end


  private

  def merchant_params
    params.permit(:name, :enabled)
  end
end