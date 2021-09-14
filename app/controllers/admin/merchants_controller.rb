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
    merchant =  Merchant.find(params[:id])
    merchant.update(merchant_params)
    redirect_to "/admin/merchants/#{merchant.id}"
  end

  private
  def merchant_params
    params.permit(:name, :id, :created_at, :updated_at)
  end
end
