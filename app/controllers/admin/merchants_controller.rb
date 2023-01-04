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

    merchant.update!(merchant_params)

    return redirect_to admin_merchants_path if params[:enabled]
    redirect_to admin_merchant_path(merchant)
    flash[:notice] = "Merchant name has been changed"
  end

  def new

  end

  private

  def merchant_params
    params.permit(:name, :enabled)
  end
end