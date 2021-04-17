class Admin::MerchantsController < ApplicationController
  def index
    @enabled_merchants = Merchant.enabled #TODO: better here or in view?
    @disabled_merchants = Merchant.disabled
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(merchant_params)
    if params[:status].present?
      redirect_to "/admin/merchants", notice: "Merchant Successfully Updated"
    else
      redirect_to "/admin/merchants/#{merchant.id}", notice: "Merchant Successfully Updated"
    end
  end

  def new
    
  end

  private
  def merchant_params
    if params[:status].present?
      params.permit(:status)
    else
      params.require(:merchant).permit(:name)
    end
  end
end