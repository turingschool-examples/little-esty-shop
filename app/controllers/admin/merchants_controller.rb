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
    merchant = Merchant.find(params[:id])
    if params[:merchant_status]
      merchant.update(merchant_params)
      redirect_to '/admin/merchants'
    else
      merchant.update(merchant_params)

      redirect_to admin_merchant_path(merchant), notice: "Successfully Updated"
    end
  end

  private
  def merchant_params
    params.permit(:name, :merchant_status)
  end
end
