class AdminMerchantsController < ApplicationController
  def index
    @enabled_merchants_array = Merchant.enabled_merchants
    @disabled_merchants_array = Merchant.disabled_merchants
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    if merchant_params[:status]
      merchant.update(merchant_params)
      redirect_to "/admin/merchants"
    else
      merchant.update(merchant_params)
      redirect_to "/admin/merchants/#{merchant.id}",  notice: "Merchant Successfully Updated"
    end
  end

  def new

  end

  def create
    merchant = Merchant.create!(merchant_params)
    redirect_to "/admin/merchants"
  end

  private

  def merchant_params
    params.permit(:name, :status)
  end

end
